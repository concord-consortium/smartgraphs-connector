module RestrictedController

  def self.included(clazz)
     clazz.class_eval {

       protected

       def admin_only
         require_roles('admin')
       end

       def require_roles(*roles)
         redirect_home unless (current_user != nil &&  current_user.has_role?(*roles))
       end

       def redirect_home(message = "Please log in as an administrator")
         flash[:notice] = "Please log in as an administrator"
         redirect_to(main_app.home_url)
       end

     }

   end
end
