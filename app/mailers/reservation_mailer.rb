class ReservationMailer < ActionMailer::Base
  default :from => "notice@couchfoodie.io"

  def notify_kitchen_owner_of_new_reservation(user)
    @user = user
    @home_page = 'http://couchfoodie.io'
    @my_kitchens_page = 'http://couchfoodie.io/users/kitchens'
    mail :subject => "Someone made a reservation to your kitchen on Couchfoodie",
         :to      => user.email,
         :from    => "reservation@couchfoodie.io"
  end
end
