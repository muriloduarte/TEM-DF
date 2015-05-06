# File: temdf_mailer.rb
# Purpose of class: Creates the body of emails according to standard,
# and requested type.
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class TemdfMailer < ActionMailer::Base
  
  default from: "temdf.unb@gmail.com"
  default to: "temdf.unb@gmail.com"

  # Email template for medical registries in the application
  def request_account
    path_date_medical_file = "public/uploads/arquivo_medico"
    attachments["arquivo_medico.pdf"] = File.read(path_date_medical_file)
  	mail(subject: "Nova solicitacao de medico", 
         body: "solicitacao de cadastro de usuario")
  end

  # Email template for contact between user and administrator
  def send_mail (subject, message, email, user_name)
   	mail(subject: subject,
		     body: "From: " + email + "\nNome: " + user_name + "\n\n" + message)
  end
  
  # Email template for registration confirmation
  def confimation_email (user_id, user_token_email, email)
    address_confirmation_page = "http://0.0.0.0:3000/confirmation/"
    link_confirm_registration = address_confirmation_page + user_id.to_s() + "/" + user_token_email.to_s()

    mail(to: email,
         subject: "Confirme seu cadastro em TEM-DF!",
         body: "Obrigado por se cadastrar!\n   
                Confirme seu cadastro clicando no link abaixo:\n\n
                #{link_confirm_registration}")
  end  
end

