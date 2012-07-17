class Activity < ActiveRecord::Base
  attr_accessible :name, :publication_status, :user, :external_activities, :investigation

  belongs_to :user
  belongs_to :investigation
  has_many :sections
  has_many :external_activities, :as => :template
end
