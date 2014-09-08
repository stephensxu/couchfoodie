class SessionsController < ApplicationController
  def create
    p "auth hash look like #{request.env['omniauth.auth']}"

    auth = request.env['omniauth.auth']
    @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

    if @user
      login!(@user)
      redirect_to users_path
    else
      redirect_to(root_url, :notice => "Invalid user credentials")
    end
  end

  def show
  end

  def destroy
    logout! if logged_in?
    
    redirect_to(root_url)
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
