require 'spec_helper'

describe SmartgraphsConnector::Portal do
  describe "publish activity" do
    after :each do
      set_original_activity
    end

    it 'should create a new activity based on the activity definition from the authoring portal' do
      act = SmartgraphsConnector::Authoring.activity(2)
      prev_size = Activity.count
      user = User.create!
      p_act = SmartgraphsConnector::Portal.publish_activity(act, user)
      p_act.should_not be_nil
      all_acts = Activity.all
      all_acts.size.should == (prev_size + 1)
      act = all_acts.last
      act.user.should == user
      act.sections.size.should == 1
      section = act.sections.last
      section.name.should == "Second Test Activity"
      section.user.should == user
      section.pages.size.should == 4
      section.pages.each_with_index do |page, i|
        page.user.should == user
        case i
        when 0
          page.page_elements.size.should == 1
          mc = page.page_elements.first.embeddable
          mc.class.should == Embeddable::MultipleChoice
          mc.prompt.should == "What color is the sky?"
          mc.choices.size.should == 4
          mc.choices[0].choice.should == "Blue"
          mc.choices[1].choice.should == "Red"
          mc.choices[2].choice.should == "Purple"
          mc.choices[3].choice.should == "Fuchsia"
          mc.choices[0].is_correct.should be_true
          mc.user.should == user
        when 1
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "Pick an integer between 3 and 7."
          open_response.user.should == user
        when 2
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "Where does the road meet the sky?"
          open_response.user.should == user
        when 4
          page.page_elements.size.should == 0
        end
      end
      act.external_activities.size.should == 1
      act.external_activities.first.user.should == user
    end

    it 'should update an existing activity based on the activity definition from the authoring portal' do
      act = SmartgraphsConnector::Authoring.activity(2)
      user1 = User.create!
      user2 = User.create!
      SmartgraphsConnector::Portal.publish_activity(act, user1)

      set_updated_activity

      act = SmartgraphsConnector::Authoring.activity(2)
      prev_size = Activity.count
      p_act = SmartgraphsConnector::Portal.publish_activity(act, user2)
      p_act.should_not be_nil

      all_acts = Activity.all
      # update still creates a new one. it just disables the old one.
      all_acts.size.should == (prev_size + 1)
      act = all_acts.last
      act.user.should == user2
      all_acts.detect{|a| a.name == "Outdated " + act.name}.should_not be_nil
      act.sections.size.should == 1
      section = act.sections.last
      section.name.should == "Second Test Activity with Updates"
      section.user.should == user2
      section.pages.size.should == 4
      section.pages.each_with_index do |page, i|
        page.user.should == user2
        case i
        when 0
          page.page_elements.size.should == 1
          mc = page.page_elements.first.embeddable
          mc.class.should == Embeddable::MultipleChoice
          mc.prompt.should == "What color is the sea?"
          mc.user.should == user2
          mc.choices.size.should == 4
          mc.choices[0].choice.should == "Green"
          mc.choices[1].choice.should == "Red"
          mc.choices[2].choice.should == "Black"
          mc.choices[3].choice.should == "Brown"
        when 1
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "What hour is noon?"
          open_response.user.should == user2
        when 2
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "What's at the bottom of the sea?"
          open_response.user.should == user2
        when 4
          page.page_elements.size.should == 0
        end
      end
      act.external_activities.size.should == 1
      act.external_activities.first.user.should == user2
    end
  end

  describe "save learner data" do
    before :each do
      act = SmartgraphsConnector::Authoring.activity(2)
      @activity = SmartgraphsConnector::Portal.publish_activity(act, User.create!)
      offering = Portal::Offering.create!(:runnable => @activity)
      @learner = Portal::Learner.create!(:offering => offering)

      SmartgraphsConnector::Portal.save_answers(JSON.parse(LEARNER_DATA), @activity)
    end

    it 'should process learner data into Saveables' do
      @learner.open_responses.size.should == 2
      @learner.multiple_choices.size.should == 1
      (@learner.open_responses + @learner.multiple_choices).each do |s|
        s.answers.size.should == 1
        case s
        when Saveable::OpenResponse
          s.open_response.should_not be_nil
          if s.prompt == "Pick an integer between 3 and 7."
            s.answer.should == "5.0"
          else
            s.answer.should == "This is some text."
          end
        when Saveable::MultipleChoice
          s.multiple_choice.should_not be_nil
          s.answer.should == "Red"
          s.answered_correctly?.should be_false
        end
      end
    end

    it 'should update Saveables when saving new learner data for a user' do
      SmartgraphsConnector::Portal.save_answers(JSON.parse(UPDATED_LEARNER_DATA), @activity)
      @learner.open_responses.size.should == 2
      @learner.multiple_choices.size.should == 1
      (@learner.open_responses + @learner.multiple_choices).each do |s|
        s.answers.size.should == 2
        case s
        when Saveable::OpenResponse
          s.open_response.should_not be_nil
          if s.prompt == "Pick an integer between 3 and 7."
            s.answer.should == "7.0"
          else
            s.answer.should == "This is totally different text."
          end
        when Saveable::MultipleChoice
          s.multiple_choice.should_not be_nil
          s.answer.should == "Blue"
          s.answered_correctly?.should be_true
        end
      end
    end
  end
end
