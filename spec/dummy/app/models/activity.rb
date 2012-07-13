class Activity < ActiveRecord::Base
  attr_accessible :name, :publication_status, :user, :external_activity

  belongs_to :user
  has_many :sections
  has_one :external_activity, :as => :template
end
