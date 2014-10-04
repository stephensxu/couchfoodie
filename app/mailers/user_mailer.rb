class UserMailer < ActionMailer::Base
  default :from => "notice@couchfoodie.io"

  def welcome_email(user)
    @user = user
    @couchfoodie_home_page = 'http://couchfoodie.io'
    mail :subject => "Mandrill rides the Rails!",
         :to      => user.email,
         :from    => "notice@codeunion.io"
  end

end
