class Embeddable::OpenResponse < ActiveRecord::Base
  attr_accessible :name, :prompt, :user

  belongs_to :user
end
