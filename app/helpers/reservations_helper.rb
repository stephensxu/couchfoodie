module ReservationsHelper
  def show_reservation_time(reservation)
    time = reservation.reserve_time.strftime("%l:%M %p")
    date = reservation.reserve_date.strftime("%Y-%m-%d %A")
    "%s %s" % [date, time]
  end
end
