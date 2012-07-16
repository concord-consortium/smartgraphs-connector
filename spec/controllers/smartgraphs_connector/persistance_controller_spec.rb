require 'spec_helper'

describe SmartgraphsConnector::PersistenceController do
  before do
    # work around a bug in routing testing
    @routes = SmartgraphsConnector::Engine.routes
    @user = User.create!
    @student = Portal::Student.create!(:user => @user)
    @learners = []
    @learners << Portal::Learner.create!(:student => @student)
    @learners << Portal::Learner.create!(:student => @student)
    @learners << Portal::Learner.create!(:student => @student)
    controller.send "current_user=", @user
  end

  def stub_has_learner(id)
    Portal::Learner.should_receive(:find).and_return(@learners[id])
    @student.has_teacher = true
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

    it 'should render a response even if not logged in' do
      controller.send "current_user=", nil
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

    it 'should render a 404 when persistence does not yet exist' do
      begin
        get :show, :learner_id => @learners[0].id
      rescue ActionController::RoutingError
      end
    end

    it 'should render the persistence content when it exists' do
      SmartgraphsConnector::Persistence.create!({:learner_id => @learners[0].id, :content => "{foo: 'bar', boo: 'baz'}" })
      get :show, :learner_id => @learners[0].id
      response.body.should == "{foo: 'bar', boo: 'baz'}"
    end

    it 'should render the persistence when the current user is an admin' do
      user = User.create!
      user.roles = ['admin']
      controller.send "current_user=", user
      SmartgraphsConnector::Persistence.create!({:learner_id => @learners[0].id, :content => "{foo: 'bar', boo: 'baz'}" })
      get :show, :learner_id => @learners[0].id
      response.body.should == "{foo: 'bar', boo: 'baz'}"
    end

    it 'should render the persistence when the current user is an manager' do
      user = User.create!
      user.roles = ['manager']
      controller.send "current_user=", user
      SmartgraphsConnector::Persistence.create!({:learner_id => @learners[0].id, :content => "{foo: 'bar', boo: 'baz'}" })
      get :show, :learner_id => @learners[0].id
      response.body.should == "{foo: 'bar', boo: 'baz'}"
    end

    it 'should render the persistence when the current user is the learner\'s teacher' do
      user = User.create!
      user.roles = ['member']
      controller.send "current_user=", user
      user.portal_teacher = true # just needs not be false or nil
      SmartgraphsConnector::Persistence.create!({:learner_id => @learners[0].id, :content => "{foo: 'bar', boo: 'baz'}" })
      stub_has_learner(0)
      get :show, :learner_id => @learners[0].id
      response.body.should == "{foo: 'bar', boo: 'baz'}"
    end

    it 'should not render the persistence if the current user is not the learner' do
      user = User.create!
      user.roles = ['member','researcher']
      controller.send "current_user=", user
      SmartgraphsConnector::Persistence.create!({:learner_id => @learners[0].id, :content => "{foo: 'bar', boo: 'baz'}" })
      get :show, :learner_id => @learners[0].id
      response.code.should == "403"
      response.body.strip.should be_empty
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
      post :update, :learner_id => @learners[1].id.to_s
      response.code.should == "200"
      p = SmartgraphsConnector::Persistence.find_by_learner_id(@learners[1].id)
      p.should_not be_nil
      p.content.should == content
    end

    it 'should update a Persistence object if one existed prior' do
      content = "{some: 'this is something', content: 'and this is something more'}"
      new_content = "{some: 'this is something changed', content: 'and this is something more', and: 'finally some other stuff'}"
      p = SmartgraphsConnector::Persistence.create!({:learner_id => @learners[2].id, :content => content})
      request.env['RAW_POST_DATA'] = new_content
      post :update, :learner_id => @learners[2].id.to_s
      response.code.should == "200"
      p.reload
      p.content.should == new_content
    end

    describe 'permission denied' do
      before :each do
        content = "{some: 'this is something', content: 'and this is something more'}"
        new_content = "{some: 'this is something changed', content: 'and this is something more', and: 'finally some other stuff'}"
        p = SmartgraphsConnector::Persistence.create!({:learner_id => @learners[2].id, :content => content})
        request.env['RAW_POST_DATA'] = new_content
      end

      it 'should not update the persistence when the current user is an admin or manager' do
        user = User.create!
        user.roles = ['admin','manager']
        controller.send "current_user=", user
        post :update, :learner_id => @learners[2].id.to_s
        response.code.should == "403"
        response.body.strip.should be_empty
      end

      it 'should not update the persistence when the current user is the learner\'s teacher' do
        user = User.create!
        user.roles = ['member']
        controller.send "current_user=", user
        user.portal_teacher = true # just needs not be false or nil
        stub_has_learner(2)
        post :update, :learner_id => @learners[2].id.to_s
        response.code.should == "403"
        response.body.strip.should be_empty
      end

      it 'should not render the persistence if the current user is not the learner' do
        user = User.create!
        user.roles = ['member','manager','researcher']
        controller.send "current_user=", user
        post :update, :learner_id => @learners[2].id.to_s
        response.code.should == "403"
        response.body.strip.should be_empty
      end
    end
  end
end
