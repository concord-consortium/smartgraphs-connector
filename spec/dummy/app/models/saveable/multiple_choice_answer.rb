class Saveable::MultipleChoiceAnswer < ActiveRecord::Base
  attr_accessible :choice, :multiple_choice, :position

  belongs_to :multiple_choice, :class_name => 'Saveable::MultipleChoice', :counter_cache => :response_count
  belongs_to :choice, :class_name => 'Embeddable::MultipleChoiceChoice'

  def answer
    if choice
      choice.choice
    else
      "not answered"
    end
  end

  def answered_correctly?
    if choice
      choice.is_correct
    else
      false
    end
  end
end
