# File: contact_controller.rb
# Purpose of class: Contact class between the user and administrators
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class ContactController < ApplicationController

	def new
  end

  # Receive contact attributes of view, and send e-mail to administrators
  def create
	  email = TemdfMailer.send_mail(params[:subject], 
	  															params[:message], 
		                      				params[:email], 
		                      				params[:name])
		email.deliver
		redirect_to root_path
  end
end
