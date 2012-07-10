require 'spec_helper'

describe SmartgraphsConnector::PersistenceController do
  before do
    # work around a bug in routing testing
    @routes = SmartgraphsConnector::Engine.routes
  end

  describe "routing" do
    it "recognizes and generates #check" do
      {:get => "persistence" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'check')
    end

    it "recognizes and generates #show" do
      {:get => "persistence/25" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'show', :learner_id => '25')
    end

    it "recognizes and generates #update" do
      {:post => "persistence/25" }.should route_to(:controller => 'smartgraphs_connector/persistence', :action => 'update', :learner_id => '25')
    end
  end

  describe "check" do
    it 'should render a blank response for check' do
      get :check
      response.code.should == "200"
      response.body.strip.should be_empty
    end
  end

  describe "show" do
    it 'should not route when learner_id is not valid' do
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

  describe "update" do
    it 'should not route when learner_id is not valid' do
      begin
        post :update, :learner_id => "foobar"
        throw "Should not have been able to route with learner_id = 'foobar'!"
      rescue ActionController::RoutingError
      end
    end

    it 'should create a Persistence object if none existed prior' do
      content = "{some: 'this is something', content: 'and this is something more'}"
      request.env['RAW_POST_DATA'] = content
      post :update, :learner_id => "27"
      response.code.should == "200"
      p = SmartgraphsConnector::Persistence.find_by_learner_id(27)
      p.should_not be_nil
      p.content.should == content
    end

    it 'should update a Persistence object if one existed prior' do
      content = "{some: 'this is something', content: 'and this is something more'}"
      new_content = "{some: 'this is something changed', content: 'and this is something more', and: 'finally some other stuff'}"
      p = SmartgraphsConnector::Persistence.create!({:learner_id => 28, :content => content})
      request.env['RAW_POST_DATA'] = new_content
      post :update, :learner_id => "28"
      response.code.should == "200"
      p.reload
      p.content.should == new_content
    end
  end
end
