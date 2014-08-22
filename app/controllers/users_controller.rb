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
    @reservations_pending = current_user.reservations.pending
    @reservations_approved = current_user.reservations.approved
    @reservations_denied = current_user.reservations.denied
    render :user_reservations_all
  end

  def reservations_pending
    @reservations = current_user.reservations.pending
    render :user_reservations_pending
  end

  def reservations_approved
    @reservations = current_user.reservations.approved
    render :user_reservations_approved
  end

  def reservations_denied
    @reservations = current_user.reservations.denied
    render :user_reservations_denied
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
