class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      if !user.admin
      	redirect_to root_url, notice: "Logged in!"
      else
      	redirect_to admin_url, notice: "Hello"
      end
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def create_from_omniauth
  auth_hash = request.env["omniauth.auth"]
  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
  if authentication.user
    user = authentication.user
    authentication.update_token(auth_hash)
    @next = root_url
    @notice = "Signed in!"
  # else: user logs in with OAuth for the first time
  else
    user = User.create_with_auth_and_hash(authentication, auth_hash)
    # you are expected to have a path that leads to a page for editing user details
    @next = edit_user_path(user)
    @notice = "User created. Please confirm or edit details"
  end

  session[:id] = user.id
  redirect_to @next, :notice => @notice
end

end