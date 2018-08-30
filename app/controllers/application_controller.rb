class ApplicationController < ActionController::Base
  helper_method :is_admin

  protected
    def is_admin
      user_signed_in? && current_user.role == 'admin'
    end

    def authenticate_admin!
      authenticate_user!
      unless is_admin
        render :file => "public/401.html", :status => :unauthorized
      end
    end
end
