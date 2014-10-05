class UsersController < ApplicationController
  before_action :require_authorization!, :only => [:kitchens, :reservations_all, :reservations_pending, :reservations_approved,
                :reservations_denied]
  def index
    if logged_in?
      redirect_to kitchens_path
    else
      render :index
    end
  end

  def kitchens
    @kitchens = Kitchen.for_user(current_user).active
    if @kitchens.empty?
      render :no_kitchen_page
    else
      render :user_created_kitchens
    end
  end

  def reservations_all
    @reservations = Reservation.for_user(current_user)
    @reservations_pending = current_user.reservations.pending.select { |reservation| reservation.in_future? }
    @reservations_approved = current_user.reservations.approved.active
    @reservations_denied = current_user.reservations.denied
    render :user_reservations_all
  end

  def reservations_pending
    @reservations = current_user.reservations.pending.order("reserve_date DESC, reserve_time DESC")
    render :user_reservations_pending
  end

  def reservations_approved
    @reservations = current_user.reservations.approved.order("reserve_date DESC, reserve_time DESC")
    render :user_reservations_approved
  end

  def reservations_denied
    @reservations = current_user.reservations.denied.order("reserve_date DESC, reserve_time DESC")
    render :user_reservations_denied
  end

  def new
    @user = User.new
  end

  private

  def require_authorization!
    redirect_to root_path unless logged_in?
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
