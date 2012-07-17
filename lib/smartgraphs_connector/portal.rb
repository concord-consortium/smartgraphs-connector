require 'digest/md5'
require 'dot_notation_hash'
module SmartgraphsConnector
  class Portal
    def self.publish_activity(activity, owner)
      portal_inv = Investigation.find_by_name(activity_name(activity))
      if portal_inv
        portal_inv = update_activity(activity, portal_inv, owner)
      else
        portal_inv = create_activity(activity, owner)
      end

      ensure_linked_external_activity(activity, portal_inv, owner)
      portal_inv
    end

    def self.save_answers(answers, portal_activity)
      if answers.learner && answers.learner.url && answers.learner.url =~ /learner\/(\d+)/
        learner = ::Portal::Learner.find($1.to_i)
        portal_pages = portal_activity.activities.first.sections.first.pages
        answers.pages.each_with_index do |p,i|
          portal_page = portal_pages[i]
          pes = portal_page.page_elements
          emb_idx = 0
          p.steps.each do |s|
            if s.responseTemplate
              embeddable = pes[emb_idx].embeddable
              emb_idx += 1
              process_reportable(s, embeddable, learner)
            end
          end
        end
      end
    end

    private

    def self.runtime_url(activity)
      ## FIXME
      SmartgraphsConnector.smartgraphs_runtime_url + "#something"
    end

    def self.ensure_linked_external_activity(activity, portal_activity, owner)
      ea = ExternalActivity.find_or_create_by_url(runtime_url(activity))
      ea.template = portal_activity.activities.first
      ea.name = activity.name
      ea.popup = true
      ea.append_learner_id_to_url = true
      ea.user = owner
      ea.save
      ea
    end

    def self.update_activity(activity, portal_activity, owner)
      new_portal_activity = create_activity(activity, owner)
      portal_activity.name = ("Outdated " + portal_activity.name)
      portal_activity.save
      old_externals = portal_activity.activities.first.external_activities
      old_externals.each do |old_external|
        old_external.publication_status = 'private'
        old_external.save
      end
      new_portal_activity
    end

    def self.create_activity(activity, owner)
      portal_inv = Investigation.create!(:name => activity_name(activity), :publication_status => "private", :user => owner)
      portal_activity = portal_inv.activities.create!(:name => activity.name, :user => owner)
      portal_section = portal_activity.sections.create!(:name => activity.name, :user => owner)
      activity.pages.each do |page|
        portal_page = portal_section.pages.create!(:name => page.name, :user => owner)
        # we only need to worry about things that are reportable
        sequence = page.sequence
        if sequence
          case sequence.type
          when /^Numeric/, /^ConstructedResponse/
            prompt = sequence.initialPrompt
            # numeric responses use a slightly different format for initialPrompt
            # instead of just a string, it's a hash: { text: "prompt" }
            prompt = prompt.is_a?(Hash) ? prompt.text : prompt
            open_res = Embeddable::OpenResponse.create(:prompt => prompt, :user => owner)
            portal_page.add_embeddable(open_res)
          when /^MultipleChoice/
            mc = Embeddable::MultipleChoice.create(:prompt => sequence.initialPrompt, :user => owner)
            correct_index = (sequence.correctAnswerIndex || -1).to_i
            sequence.choices.each_with_index do |choice, i|
              c = mc.choices.create!(:choice => choice, :is_correct => (i == correct_index))
            end
            portal_page.add_embeddable(mc)
            portal_page.save
          else
          end
        end
      end
      portal_inv
    end

    def self.process_reportable(answers, embeddable, learner)
      answer = answers.responseTemplate["values"].first
      case embeddable
      when Embeddable::OpenResponse
        process_open_response(embeddable, learner, answer)
      when Embeddable::MultipleChoice
        # smartgraphs answer indexes are 1-based, ruby uses 0-based arrays
        choice = embeddable.choices[answer.to_i - 1]
        process_multiple_choice(choice, learner)
      end
    end

    def self.process_open_response(open_response, learner, answer)
      saveable_open_response = ::Saveable::OpenResponse.find_or_create_by_learner_id_and_offering_id_and_open_response_id(learner.id, learner.offering.id, open_response.id)
      if saveable_open_response.response_count == 0 || saveable_open_response.answers.last.answer != answer
        saveable_open_response.answers.create(:answer => answer)
      end
    end

    def self.process_multiple_choice(choice, learner)
      multiple_choice = choice.multiple_choice
      saveable = ::Saveable::MultipleChoice.find_or_create_by_learner_id_and_offering_id_and_multiple_choice_id(learner.id, learner.offering.id, multiple_choice.id)
      if saveable.answers.empty? || saveable.answers.last.choice_id != choice.id
        saveable.answers.create(:choice => choice)
      end
    end

    def self.activity_name(activity)
      "External: #{id_hash(activity)}"
    end

    def self.id_hash(activity)
       Digest::MD5.hexdigest("#{SmartgraphsConnector.authoring_url}-#{activity.id}")
    end
  end
end
