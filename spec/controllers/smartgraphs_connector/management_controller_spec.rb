require 'spec_helper'

describe SmartgraphsConnector::ManagementController do
  render_views
  before do
    # work around a bug in routing testing
    @routes = SmartgraphsConnector::Engine.routes
    @user = User.new
    @user.roles = ['admin']
    controller.send "current_user=", @user
  end

  def set_non_admin
    user = User.new
    user.roles = ['manager', 'member', 'researcher']
    controller.send "current_user=", user
  end

  def verify_redirect_home
    response.code.should == "302"
    response.should redirect_to(controller.main_app.home_url)
    flash[:error].should be_nil
    flash[:notice].should == "Please log in as an administrator"
  end

  describe "routing" do
    it "recognizes and generates #index" do
      {:get => "manage/activities" }.should route_to(:controller => 'smartgraphs_connector/management', :action => 'index')
    end

    it "recognizes and generates #show" do
      {:get => "manage/activity/2" }.should route_to(:controller => 'smartgraphs_connector/management', :action => 'activity', :id => '2')
    end

    it "recognizes and generates #show" do
      {:post => "manage/activity/2" }.should route_to(:controller => 'smartgraphs_connector/management', :action => 'publish', :id => '2')
    end
  end

  describe "index" do
    it 'should render a list of activities from the portal' do
      get :index
      response.body.should match /\/activity\/1/
      response.body.should match /\/activity\/2/
      response.body.should match /\/activity\/3/
    end

    it 'should not render a list of activities when the current user is not an admin' do
      set_non_admin
      get :index
      verify_redirect_home
    end
  end

  describe "activity" do
    it 'should not route when id is not valid' do
      begin
        get :activity, :id => "foobar"
        throw "Should not have been able to route with id = 'foobar'!"
      rescue ActionController::RoutingError
      end
    end

    it 'should render a 404 when activity does not yet' do
      begin
        get :activity, :id => 34
      rescue ActionController::RoutingError
      end
    end

    it 'should render the activity when it exists' do
      get :activity, :id => 2
      response.body.should match /Name:.*?Second Test Activity/m
      response.body.should match /ID:.*?2/m
      response.body.should match /Author:.*?Aaron Unger/m
      response.body.should match /<form.*?action="#{publish_activity_path(2)}"/
      response.body.should match /<input.*?value="Publish"/
    end

    it 'should not render the activity when the current user is not an admin' do
      set_non_admin

      get :activity, :id => 2
      verify_redirect_home
    end
  end

  describe "publish" do
    before :each do
      # ensure that the flash hash remains set
      @controller.instance_eval { flash.stub!(:sweep) }
    end

    it 'should publish the activity when publish is clicked' do
      post :publish, :id => 2
      response.code.should == "302"
      response.should redirect_to(manage_activity_path(2))
      flash[:error].should be_nil
      flash[:notice].should == "Activity was published."
    end

    it 'should notify of errors when the activity publishing fails' do
      pending 'simulate error publishing'
      post :publish, :id => 2
      response.code.should == "302"
      response.should redirect_to(manage_activity_path(2))
      flash[:notice].should be_nil
      flash[:error].should == "Activity publish failed."
    end

    it 'should not publish if the current user is not an admin' do
      set_non_admin

      post :publish, :id => 2
      verify_redirect_home
    end
  end
end
