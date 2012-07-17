class Investigation < ActiveRecord::Base
  attr_accessible :activities, :user, :name, :publication_status

  belongs_to :user
  has_many :activities
  has_many :external_activities, :as => :template
end
