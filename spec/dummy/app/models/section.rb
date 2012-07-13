class Section < ActiveRecord::Base
  attr_accessible :name, :user, :activity, :external_activity

  belongs_to :user
  belongs_to :activity
  has_many :pages
  has_one :external_activity, :as => :template
end
