module ReservationsHelper
  def show_reservation_time(reservation)
    time = reservation.reserve_time.strftime("%A %l:%M %p")
    "%s, %s" % [reservation.reserve_date, time]
  end
end
