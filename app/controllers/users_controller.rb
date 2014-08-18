class UsersController < ApplicationController
  def index
    current_user
    @kitchen = Kitchen.new
    @reservation = Reservation.new
    @kitchens = Kitchen.order("created_at DESC")
    render :index
  end

  def kitchens
    if logged_in?
      @kitchens = Kitchen.for_user(current_user)
      render :user_created_kitchens
    else
      redirect_to root_url
    end
  end

  def reservations_all
    if logged_in?
      @reservations = Reservation.for_user(current_user)
      @reservations_pending = @reservations.select { |reservation| reservation.status == "pending" }
      @reservations_approved = @reservations.select { |reservation| reservation.status == "approved" }
      @reservations_denied = @reservations.select { |reservation| reservation.status == "denied" }
      render :user_reservations_all
    else
      redirect_to root_url
    end
  end

  def reservations_pending
    if logged_in?
      @reservations = Reservation.for_user(current_user).for_status("pending")
      render :user_created_reservations
    else
      redirect_to root_url
    end
  end

  def reservations_approved
    if logged_in?
      @reservations = Reservation.for_user(current_user).for_status("approved")
      render :user_created_reservations
    else
      redirect_to root_url
    end
  end

  def reservations_denied
    if logged_in?
      @reservations = Reservation.for_user(current_user).for_status("denied")
      render :user_created_reservations
    else
      redirect_to root_url
    end
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
