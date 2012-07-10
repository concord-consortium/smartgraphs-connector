require_dependency "smartgraphs_connector/application_controller"

module SmartgraphsConnector
  class PersistenceController < ApplicationController
    def check
      head :ok
    end

    def show
      if (persistence = Persistence.find_by_learner_id(params[:learner_id].to_i)) && persistence.content
        render :json => persistence.content
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    def update
      body = request.body.read
      persistence = Persistence.find_or_create_by_learner_id(params[:learner_id].to_i)
      persistence.content = body
      if persistence.save
        head :ok
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
