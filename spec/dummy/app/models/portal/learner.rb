class Portal::Learner < ActiveRecord::Base
  attr_accessible :offering

  belongs_to :offering

  has_many :open_responses, :class_name => "Saveable::OpenResponse"
  has_many :multiple_choices, :class_name => "Saveable::MultipleChoice"
end
