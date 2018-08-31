class ApplicationController < ActionController::Base
  helper_method :is_admin
  
  def home
    if is_admin
      reditect_to users_path
    elsif user_signed_in?
      redirect_to suite_solutions_start_path
    else
      authenticate_user!
    end
  end

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
