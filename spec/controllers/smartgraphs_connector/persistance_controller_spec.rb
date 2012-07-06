require 'spec_helper'

describe SmartgraphsConnector::PersistenceController do
  describe "routing" do
    before do
      # work around a bug in routing testing
      @routes = SmartgraphsConnector::Engine.routes
    end

    it "recognizes and generates #show" do
      {:get => "persistence/25" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'show', :learner_id => '25')
    end

    it "recognizes and generates #update" do
      {:post => "persistence/25" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'update', :learner_id => '25')
    end
  end
end
