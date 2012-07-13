class Section < ActiveRecord::Base
  attr_accessible :name, :user, :activity

  belongs_to :user
  belongs_to :activity
  has_many :pages
end
