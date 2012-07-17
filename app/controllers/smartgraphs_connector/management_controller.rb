require_dependency "smartgraphs_connector/application_controller"

module SmartgraphsConnector
  class ManagementController < ApplicationController
    before_filter :admin_only

    def index
      # present a list of activities in the authoring portal which can be managed
      @activities = SmartgraphsConnector::Authoring.activities
    end

    def activity
      # present management options for an individual activity
      @activity = SmartgraphsConnector::Authoring.activity(params[:id])
      unless @activity
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    def publish
      @activity = SmartgraphsConnector::Authoring.activity(params[:id])
      begin
        SmartgraphsConnector::Portal.publish_activity(@activity, current_user)
        flash[:notice] = "Activity was published."
      rescue => e
        flash[:error] = "Activity publish failed."
      end
      redirect_to manage_activity_path(@activity.id)
    end
  end
end
