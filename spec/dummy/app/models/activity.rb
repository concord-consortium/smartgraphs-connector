class Activity < ActiveRecord::Base
  attr_accessible :name, :publication_status, :user, :external_activities

  belongs_to :user
  has_many :sections
  has_many :external_activities, :as => :template
end
