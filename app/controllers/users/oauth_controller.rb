class Users::OauthController < Devise::OmniauthCallbacksController
  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    new_user = User.from_omniauth(request.env["omniauth.auth"])
    new_user.password = SecureRandom.hex
    user = User.where(uid: new_user.uid, provider: new_user.provider).first
    @user = if user
      user
    else
      new_user.save!
      new_user
    end
    sign_in(:user, @user)
    redirect_to root_path
  end

  def failure
    redirect_to root_path
  end
end
