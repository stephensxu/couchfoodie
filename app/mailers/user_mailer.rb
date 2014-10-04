class UserMailer < ActionMailer::Base
  default :from => "notice@codeunion.io"

  def welcome_email(user)

    mail :subject => "Mandrill rides the Rails!",
         :to      => user.email,
         :from    => "notice@codeunion.io"
  end

end
