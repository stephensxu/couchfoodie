class SessionsController < ApplicationController
  def create

    auth = request.env['omniauth.auth']
    @user = User.create_or_find_with_omniauth(auth)

    if @user
      @user.sign_in
      login!(@user)
      redirect_to kitchens_path
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
