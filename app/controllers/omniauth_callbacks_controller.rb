class OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def all
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.user_attributes"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  alias_method :google_oauth2, :all
  alias_method :facebook, :all
  alias_method :github, :all
  alias_method :linkedin, :all
  alias_method :twitter, :all
  alias_method :passthru, :all

end
