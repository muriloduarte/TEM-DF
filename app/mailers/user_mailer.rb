# File: user_mailer.rb
# Purpose of class: Creates the body of emails to reset user account password
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class UserMailer < ActionMailer::Base
  
  default from: "temdf.unb@gmail.com"

  # Email Template for user password reset
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Password Reset")
  end
end
