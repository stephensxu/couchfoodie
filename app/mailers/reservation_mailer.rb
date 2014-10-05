class ReservationMailer < ActionMailer::Base
  default :from => "noreply@couchfoodie.io"

  def notify_kitchen_owner_of_new_reservation(user)
    @user = user
    @home_page = 'http://couchfoodie.io'
    @my_kitchens_page = 'http://couchfoodie.io/users/kitchens'
    mail :subject => "Someone made a reservation to your kitchen on Couchfoodie",
         :to      => user.email,
         :from    => "noreply@couchfoodie.io"
  end

  def notify_guest_reservation_approval(user)
    @user = user
    @home_page = 'http://couchfoodie.io'
    mail :subject => "Your reservation is approved on Couchfoodie",
         :to      => user.email,
         :from    => "noreply@couchfoodie.io"
  end

  def notify_guest_reservation_denial(user)
    @user = user
    @home_page = 'http://couchfoodie.io'
    mail :subject => "Your reservation is declined on Couchfoodie",
         :to      => user.email,
         :from    => "noreply@couchfoodie.io"
  end
end
