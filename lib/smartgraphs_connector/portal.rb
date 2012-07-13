require 'digest/md5'
require 'dot_notation_hash'
module SmartgraphsConnector
  SG_RUNTIME = "http://smartgraphs.concord.org/"
  class Portal
    def self.publish_activity(activity)
      # todo
      portal_activity = Activity.find_by_name(activity_name(activity))
      if portal_activity
        portal_activity = update_activity(activity, portal_activity)
      else
        portal_activity = create_activity(activity)
      end

      ensure_linked_external_activity(activity, portal_activity)
    end

    private

    def self.runtime_url(activity)
      ## FIXME
      SG_RUNTIME + "something"
    end

    def self.ensure_linked_external_activity(activity, portal_activity)
      ea = ExternalActivity.find_or_create_by_url(runtime_url(activity))
      ea.template = portal_activity
      ea.name = activity.name
      ea.popup = true
      ea.append_learner_id_to_url = true
      ea.save
      ea
    end

    def self.update_activity(activity, portal_activity)
      new_portal_activity = create_activity(activity)
      portal_activity.name = ("Outdated " + portal_activity.name)
      portal_activity.save
      old_external = portal_activity.external_activity
      old_external.publication_status = 'private'
      old_external.save
      new_portal_activity
    end

    def self.create_activity(activity)
      portal_activity = Activity.create!(:name => activity_name(activity), :publication_status => "private")
      portal_section = portal_activity.sections.create!(:name => activity.name)
      activity.pages.each do |page|
        portal_page = portal_section.pages.create!(:name => page.name)
        # we only need to worry about things that are reportable
        sequence = page.sequence
        if sequence
          case sequence.type
          when /^Numeric/, /^ConstructedResponse/
            prompt = sequence.initialPrompt
            # numeric responses use a slightly different format for initialPrompt
            # instead of just a string, it's a hash: { text: "prompt" }
            prompt = prompt.is_a?(Hash) ? prompt.text : prompt
            open_res = Embeddable::OpenResponse.create(:prompt => prompt)
            portal_page.add_embeddable(open_res)
          when /^MultipleChoice/
            mc = Embeddable::MultipleChoice.create(:prompt => sequence.initialPrompt)
            correct_index = (sequence.correctAnswerIndex || -1).to_i
            sequence.choices.each_with_index do |choice, i|
              c = mc.choices.create!(:choice => choice, :is_correct => (i == sequence.correct_index))
            end
            portal_page.add_embeddable(mc)
            portal_page.save
          else
          end
        end
      end
      portal_activity
    end

    def self.activity_name(activity)
      "External: #{id_hash(activity)}"
    end

    def self.id_hash(activity)
       Digest::MD5.hexdigest("#{SmartgraphsConnector::AUTHORING_URL}-#{activity.id}")
    end
  end
end
