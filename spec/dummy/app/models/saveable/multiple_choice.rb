class Saveable::MultipleChoice < ActiveRecord::Base
  attr_accessible :learner, :multiple_choice

  belongs_to :learner, :class_name => 'Portal::Learner'
  belongs_to :offering, :class_name => 'Portal::Offering'
  belongs_to :multiple_choice, :class_name => 'Embeddable::MultipleChoice'

  has_many :answers, :order => :position, :class_name => 'Saveable::MultipleChoiceAnswer'

  def answer
    if answered?
      answers.last.answer
    else
      "not answered"
    end
  end

  def answered?
    answers.length > 0
  end

  def answered_correctly?
    if answered?
      answers.last.answered_correctly?
    else
      false
    end
  end
end
