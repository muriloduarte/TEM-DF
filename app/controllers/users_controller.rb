require "bcrypt"

# File: users_controller.rb
# Purpose of class: Contain action methods for users view.
# This software follows GPL license.
# TEM-DF Group.
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília.
class UsersController < ApplicationController
  # Method to verify if the user is admin and set distinct values
  def index
    @user = User.find_by_id(session[:remember_token])
    if @user && @user.username == "admin" 
      @users = User.all
    else
      redirect_to root_path
    end
  end

  # Method to create a user
  def create
    @user = User.new(user_params)
    # Check the user type 
    @document = params[:user][:document]
    if @user.account_status == false && !@document
      flash.now.alert = "Você precisa anexar um documento!"
      render "new"
    # Check whether the password and password_confirmation are the same
    elsif @user.password == @user.password_confirmation 
      @user.account_status = false
      if @user.save
        upload @document
        # Check whether the user is common 
        if @user_params_document == nil
          # Generate a random number for use it in update password
          random = Random.new
          @user.update_attribute(:token_email, random.seed)
          @user.update_attribute(:medic_type_status, false)
          TemdfMailer.confimation_email(@user.id, @user.token_email, @user.email).deliver
          flash[:notice] = "Por favor confirme seu cadastro pela mensagem enviada ao seu email!"
        # Or a medic user
        else
          @user.update_attribute(:medic_type_status, true)
          flash[:notice] = "Nossa equipe vai avaliar seu cadastro. Por favor aguarde a nossa aprovação para acessar sua conta!"
        end
        redirect_to root_path
      else
        render "new"
      end
    else
      render "new"
    end
  end

  # Auxiliar method to create a user
  def new
    @user = User.new
  end

  # Method to find a user by id and assist to update user's information
  def edit
    @user = User.find_by_id(session[:remember_token])
  end

  # Method to find a user by id and assist to update user's password
  def edit_password
    @user = User.find_by_id(session[:remember_token]) 
  end

  # Method to update user's information
  def update
    @user = User.find_by_id(session[:remember_token])
    if @user
    	# Admin's update
      if @user.username == "admin" 
        @email = params[:user][:email]
        @user_from_email = User.find_by_email(@email)
        if @user_from_email && @user != @user_from_email
          flash[:alert] = "Email já existente"
          render "edit" 
        else 
          @user.update_attribute(:email , @email)
          redirect_to root_path, notice: 'Usuário alterado!'
        end
      # Commom user's update 
      else 
        @username = params[:user][:username]
        @email = params[:user][:email]
        @user_from_username = User.find_by_username(@username)
        @user_from_email = User.find_by_email(@email)
        # Check if username is in use
        if @user_from_username && @user != @user_from_username
          flash[:alert] = "Nome já existente"
          render "edit"
        # Check if the email is in use
        elsif @user_from_email && @user != @user_from_email
          flash[:alert] = "Email já existente"
          render "edit" 
        # If not update attributes
        else 
          @user.update_attribute(:username , @username)
          @user.update_attribute(:email , @email)
          redirect_to root_path, notice: "Usuário alterado!"
        end
      end
    else
      redirect_to root_path
    end
  end

  # Method to update user's password
  def update_password
    @user_session = User.find_by_id(session[:remember_token])
    # Check whether the user is logged
    if @user_session
        @user = User.authenticate(@user_session.username, params[:user][:password])
        # Check whether the current password is correct
        if @user
        	@new_password = params[:user][:new_password]
        	@password_confirmation = params[:user][:password_confirmation]
        	# Check whether new password and confirmation password are the same
        	if @password_confirmation == @new_password && !@new_password.blank?
          	@user.update_attribute(:password, @new_password)
          	redirect_to root_path, notice: "Alteração feita com sucesso"
        	else
          	redirect_to edit_password_path, alert: "Confirmação nao confere ou campo vazio"
        	end
        else
        	redirect_to edit_password_path, alert: "Senha errada"
        end
    else
      redirect_to edit_password_path
    end
  end

  # Method to desactivate a user
  def deactivate
    @user = User.find_by_id(session[:remember_token])
    # Admin's deactivate
    if @user && @user.username != "admin"
        @user.update_attribute(:account_status, false)
        redirect_to logout_path
    # User's deactivate
    else
      @user = User.find_by_id(params[:id])
      if @user
        @user.update_attribute(:account_status, false)
        redirect_to(action: "index")
      else
        redirect_to root_path
      end
    end
  end

  # Method to reactivate a user
  def reactivate
    @user = User.find_by_id(params[:id])
    if @user
      @user.update_attribute(:account_status, true)
      redirect_to(action: "index")
    else
      redirect_to root_path
    end
  end

  # Method to verify the token from user and confirm account
  def confirmation_email
    @user = User.find_by_id_and_token_email(params[:id],params[:token_email])
    @message = ""
    # Check if the user and token email are equivalent
    if @user && @user.token_email
      @user.update_attribute(:account_status, true)
      @user.update_attribute(:token_email, nil)
      @message = "Cadastro Confirmado!"
    else
      @message = "Link inválido!"
    end
    redirect_to root_path, notice: @message
  end

  private
    #Method to set user's params
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :account_status)
    end

    # Method to upload an archive 
    def upload(uploaded_io)
        if uploaded_io
          File.open(Rails.root.join('public', 'uploads', 'arquivo_medico'), 'wb') { |file| file.write(uploaded_io.read) }
          # Send file to temdf email
          TemdfMailer.request_account.deliver
        else 
          # Nothing to do
        end
    end
end