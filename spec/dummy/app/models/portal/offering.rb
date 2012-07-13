class Portal::Offering < ActiveRecord::Base
  attr_accessible :runnable

  belongs_to :runnable, :polymorphic => true
end
