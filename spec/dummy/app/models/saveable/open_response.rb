class Saveable::OpenResponse < ActiveRecord::Base
  attr_accessible :learner, :open_response

  belongs_to :learner, :class_name => 'Portal::Learner'
  belongs_to :offering, :class_name => 'Portal::Offering'
  belongs_to :open_response, :class_name => 'Embeddable::OpenResponse'

  has_many :answers, :order => :position, :class_name => 'Saveable::OpenResponseAnswer'

  delegate :prompt, :to => :open_response, :class_name => 'Embeddable::OpenResponse'

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
end
