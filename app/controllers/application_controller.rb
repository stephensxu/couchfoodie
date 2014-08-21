class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil if session[:user_id].blank?

    @current_user ||= User.find_by_id(session[:user_id])
  end

  def login!(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout!
    @current_user = nil
    session.clear
  end

  def logged_in?
    current_user.present?
  end

  def redirect_if_logged_in!(url = root_url)
    if logged_in?
      redirect_to(url)
    end
  end

  def total_pending_reservations
    return nil if session[:user_id].blank?

    current_user
    pending_reservations_each_kitchen = @current_user.kitchens.map { |kitchen| kitchen.reservations.pending.count }
    pending_reservations_each_kitchen.empty? ? 
    @total_pending_reservations = 0 : @total_pending_reservations = pending_reservations_each_kitchen.inject(:+)
    @total_pending_reservations
  end
end
