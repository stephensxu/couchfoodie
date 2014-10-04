class UserMailer < ActionMailer::Base
  default :from => "notice@couchfoodie.io"

  def welcome_email(user)
    
    mail :subject => "Mandrill rides the Rails!",
         :to      => user.email,
         :from    => "notice@couchfoodie.io"
  end
end
