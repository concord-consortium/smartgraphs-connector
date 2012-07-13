class Embeddable::MultipleChoiceChoice < ActiveRecord::Base
  attr_accessible :choice, :is_correct, :multiple_choice

  belongs_to :multiple_choice, :class_name => 'Embeddable::MultipleChoice'
end
