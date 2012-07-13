class Embeddable::MultipleChoice < ActiveRecord::Base
  attr_accessible :name, :user, :prompt

  belongs_to :user
  has_many :choices, :class_name => 'Embeddable::MultipleChoiceChoice'
end
