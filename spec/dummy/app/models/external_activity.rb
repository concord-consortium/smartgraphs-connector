class ExternalActivity < ActiveRecord::Base
  attr_accessible :name, :user, :template, :url, :append_learner_id_to_url, :popup

  belongs_to :user
  belongs_to :template, :polymorphic => true
end
