class UsersController < ApplicationController
  def index
    current_user
    @kitchen = Kitchen.new
    @reservation = Reservation.new
    @kitchens = Kitchen.order('created_at DESC')
    render :index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
  end
end
