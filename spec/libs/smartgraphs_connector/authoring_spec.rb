require 'spec_helper'

describe SmartgraphsConnector::Authoring do

  it 'should load the activities list from the authoring app' do
    acts = SmartgraphsConnector::Authoring.activities
    acts.size.should == 3
    acts.map {|a| a.name }.should == ["one", "two", "three"]
  end

  it 'should load an activity from the authoring app' do
    act = SmartgraphsConnector::Authoring.activity(2)
    act.name.should == "Second Test Activity"
    act.pages.size.should == 4
  end

  end
end
