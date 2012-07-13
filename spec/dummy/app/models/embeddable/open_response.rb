class Embeddable::OpenResponse < ActiveRecord::Base
  attr_accessible :name, :prompt, :user_id
end
