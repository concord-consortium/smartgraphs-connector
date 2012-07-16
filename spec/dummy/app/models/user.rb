class User < ActiveRecord::Base
  # stub some attributes to make it easier to test
  attr_accessor :roles, :portal_teacher

  def has_role?(*role_list)
    (@roles & role_list.flatten).length > 0
  end
end
