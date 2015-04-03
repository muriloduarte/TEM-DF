################################################################################File: user_mailer.rb
#Purpose: Creates the body of emails to reset user account password
#Notice: TEM-DF. Todos Direitos Reservados
###############################################################################

class UserMailer < ActionMailer::Base
  
  default from: "temdf.unb@gmail.com"

  # Email Template for user password reset
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Password Reset")
  end
end
