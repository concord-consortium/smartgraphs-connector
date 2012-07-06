require_dependency "smartgraphs_connector/application_controller"

module SmartgraphsConnector
  class PersistenceController < ApplicationController
    def show
      if (persistence = Persistence.find_by_learner_id(params[:learner_id].to_i)) && persistence.content
        render :json => persistence.content
      else
        render :json => {}
      end
    end

    def update
      render :nothing => true
    end
  end
end
