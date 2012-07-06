require 'spec_helper'

describe SmartgraphsConnector::Persistence do
  describe "basics" do
    it 'should create a Persistence object' do
      SmartgraphsConnector::Persistence.create!({:learner_id => 1, :content => "Some content"})
    end
  end
end
