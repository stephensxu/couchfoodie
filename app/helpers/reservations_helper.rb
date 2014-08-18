module ReservationsHelper
  def show_reservation_time(reservation)
    reservation.reserve_time.strftime("%A %l:%M %p")
  end
end
