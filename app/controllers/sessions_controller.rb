# Encoding UTF-8
# Create and destroy sessions when users perform login or logout
class SessionsController < ApplicationController

  def new
  end

  # Create sessions when users perform login 
  def create
    user = User.authenticate(params[:username], params[:password])
    if user && user.account_status == true
      session[:remember_token] = user.id
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Bem vindo ao TEM-DF! :D"
    else
      flash.now.alert = "Usuário ou senha inválidos"
      render "new"
    end
  end

  # Destroy sessions when users perform logout
  def destroy
    session[:remember_token] = nil
    session[:user_id] = nil
    redirect_to root_path, :notice => "Tchau! Volte sempre! :)"
  end
end
