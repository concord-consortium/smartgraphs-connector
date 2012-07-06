require 'spec_helper'

describe SmartgraphsConnector::PersistenceController do
  before do
    # work around a bug in routing testing
    @routes = SmartgraphsConnector::Engine.routes
  end

  describe "routing" do
    it "recognizes and generates #show" do
      {:get => "persistence/25" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'show', :learner_id => '25')
    end

    it "recognizes and generates #update" do
      {:post => "persistence/25" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'update', :learner_id => '25')
    end
  end

  describe "show" do
    it 'should render a 404 when learner_id is not valid' do
      begin
        get :show, :learner_id => "foobar"
        throw "Should not have been able to route with learner_id = 'foobar'!"
      rescue ActionController::RoutingError
      end
    end

    it 'should render an empty json when persistence does not yet exist' do
      get :show, :learner_id => 34
      response.body.should == "{}"
    end

    it 'should render the persistence content when it exists' do
      SmartgraphsConnector::Persistence.create!({:learner_id => 34, :content => "{foo: 'bar', boo: 'baz'}" })
      get :show, :learner_id => 34
      response.body.should == "{foo: 'bar', boo: 'baz'}"
    end
  end
end
