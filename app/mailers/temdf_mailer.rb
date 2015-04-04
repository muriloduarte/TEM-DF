# File: temdf_mailer.rb
# Purpose of class: Creates the body of emails according to standard,
# and requested type.
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class TemdfMailer < ActionMailer::Base
  
  default from: "temdf.unb@gmail.com"

  # Email template for medical registries in the application
  def request_account
    path_date_medical_file = "public/uploads/arquivo_medico"
    attachments["arquivo_medico.pdf"] = File.read(path_date_medical_file)
  	mail(to: "temdf.unb@gmail.com", 
         subject: "Nova solicitacao de medico", 
         body: "solicitacao de cadastro de usuario")
  end

  # Email template for contact between user and administrator
  def send_mail (subject, message, email, name)
   	mail(to: "temdf.unb@gmail.com", 
         subject: subject,
		     body: "From: " + email + "\nNome: " + name + "\n\n" + message)
  end
  
  # Email template for registration confirmation
  def confimation_email (id, token_email, email)
    link = "http://0.0.0.0:3000/confirmation/" + id.to_s() + "/" + token_email.to_s()

    mail(to: email,
         subject: "Confirme seu cadastro em TEM-DF!",
         body: "Confirme seu cadastro no link abaixo:\n\n#{link}")
  end  
end

