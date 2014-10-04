class SessionsController < ApplicationController
  def create

    auth = request.env['omniauth.auth']
    @user = User.create_or_find_with_omniauth(auth)

    if @user
      @user.sign_in
      p UserMailer.welcome_email(current_user)
      UserMailer.welcome_email(current_user).deliver
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

end
