class ApplicationController < ActionController::Base
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
