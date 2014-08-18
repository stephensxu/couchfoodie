class UsersController < ApplicationController
  before_action :require_authorization!, :only => [:reservations_all, :reservations_pending, :reservations_approved,
                :reservations_denied]

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
    @reservations = Reservation.for_user(current_user)
    @reservations_pending = @reservations.select { |reservation| reservation.status == "pending" }
    @reservations_approved = @reservations.select { |reservation| reservation.status == "approved" }
    @reservations_denied = @reservations.select { |reservation| reservation.status == "denied" }
    render :user_reservations_all
  end

  def reservations_pending
    @reservations = Reservation.for_user(current_user).for_status("pending")
    render :user_created_reservations
  end

  def reservations_approved
    @reservations = Reservation.for_user(current_user).for_status("approved")
    render :user_created_reservations
  end

  def reservations_denied
    @reservations = Reservation.for_user(current_user).for_status("denied")
    render :user_created_reservations
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

  def require_authorization!
    head(:forbidden) unless logged_in?
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
  end
end
