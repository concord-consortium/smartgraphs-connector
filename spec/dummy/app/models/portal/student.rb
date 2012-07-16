class Portal::Student < ActiveRecord::Base
  attr_accessible :user

  belongs_to :user

  # this gets stubbed out in the tests... here to document what api we're using
  def has_teacher?(teacher)
    return @has_teacher
  end

  def has_teacher=(has)
    @has_teacher = has
  end
end
