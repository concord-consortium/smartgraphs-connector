require 'spec_helper'

describe SmartgraphsConnector::Portal do
  describe "publish activity" do
    after :each do
      set_original_activity
    end

    it 'should create a new activity based on the activity definition from the authoring portal' do
      act = SmartgraphsConnector::Authoring.activity(2)
      prev_size = Activity.count
      SmartgraphsConnector::Portal.publish_activity(act)
      all_acts = Activity.all
      all_acts.size.should == (prev_size + 1)
      act = all_acts.last
      act.sections.size.should == 1
      section = act.sections.last
      section.name.should == "Second Test Activity"
      section.pages.size.should == 4
      section.pages.each_with_index do |page, i|
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
        when 1
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "Pick an integer between 3 and 7."
        when 2
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "Where does the road meet the sky?"
        when 4
          page.page_elements.size.should == 0
        end
      end
      act.external_activity.should_not be_nil
    end

    it 'should update an existing activity based on the activity definition from the authoring portal' do
      act = SmartgraphsConnector::Authoring.activity(2)
      SmartgraphsConnector::Portal.publish_activity(act)

      set_updated_activity

      act = SmartgraphsConnector::Authoring.activity(2)
      prev_size = Activity.count
      SmartgraphsConnector::Portal.publish_activity(act)

      all_acts = Activity.all
      # update still creates a new one. it just disables the old one.
      all_acts.size.should == (prev_size + 1)
      act = all_acts.last
      all_acts.detect{|a| a.name == "Outdated " + act.name}.should_not be_nil
      act.sections.size.should == 1
      section = act.sections.last
      section.name.should == "Second Test Activity with Updates"
      section.pages.size.should == 4
      section.pages.each_with_index do |page, i|
        case i
        when 0
          page.page_elements.size.should == 1
          mc = page.page_elements.first.embeddable
          mc.class.should == Embeddable::MultipleChoice
          mc.prompt.should == "What color is the sea?"
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
        when 2
          page.page_elements.size.should == 1
          open_response = page.page_elements.first.embeddable
          open_response.class.should == Embeddable::OpenResponse
          open_response.prompt.should == "What's at the bottom of the sea?"
        when 4
          page.page_elements.size.should == 0
        end
      end
      act.external_activity.should_not be_nil
    end
  end
end
