class PageElement < ActiveRecord::Base
  attr_accessible :position, :user, :page, :embeddable

  belongs_to :user
  belongs_to :page
  belongs_to :embeddable, :polymorphic => true
end
