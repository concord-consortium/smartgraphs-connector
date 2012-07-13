class Saveable::OpenResponseAnswer < ActiveRecord::Base
  attr_accessible :answer, :open_response, :position

  belongs_to :open_response, :class_name => 'Saveable::OpenResponse', :counter_cache => :response_count
end
