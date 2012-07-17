module SmartgraphsConnector
  class Persistence < ActiveRecord::Base
    attr_protected :id, :created_at, :updated_at
    belongs_to :learner, :class_name => "Portal::Learner"
  end
end
