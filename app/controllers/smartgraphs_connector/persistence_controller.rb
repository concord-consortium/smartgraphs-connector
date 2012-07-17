require_dependency "smartgraphs_connector/application_controller"

module SmartgraphsConnector
  class PersistenceController < ApplicationController
    before_filter :find_learner, :except => :check
    before_filter :can_read,  :only => :show
    before_filter :can_write, :only => :update

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
      persistence = Persistence.find_or_create_by_learner_id(@learner.id)
      persistence.content = body
      template = @learner.offering.runnable.template
      SmartgraphsConnector::Portal.save_answers(JSON.parse(body), template.investigation) if template
      if persistence.save
        head :ok
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    protected

    def find_learner
      @learner = ::Portal::Learner.find(params[:learner_id].to_i) rescue nil
      raise ActionController::RoutingError.new('Not Found') unless @learner
      true
    end

    def can_read
      can = (is_current_user? || is_admin? || is_learners_teacher?)
      head :forbidden unless can
      return can
    end

    def can_write
      can = is_current_user?
      head :forbidden unless can
      return can
    end

    def is_current_user?
      current_user == @learner.student.user
    end

    def is_admin?
      current_user.has_role?('admin', 'manager')
    end

    def is_learners_teacher?
      if current_user.portal_teacher
        return @learner.student.has_teacher?(current_user.portal_teacher)
      end
      return false
    end
  end
end
