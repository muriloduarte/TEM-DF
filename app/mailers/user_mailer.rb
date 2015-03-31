# Creates the body of emails to reset user account password
class UserMailer < ActionMailer::Base
  
  default from: "temdf.unb@gmail.com"

  # Email Template for user password reset
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Password Reset")
  end
end
