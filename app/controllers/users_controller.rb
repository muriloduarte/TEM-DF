# File: users_controller.rb 
# Purpose of class: This class is a controller and contains action methods for 
# users view.
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
require "bcrypt"

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
    if @user.account_status == false && !params[:user][:document]
      flash.now.alert = "Você precisa anexar um documento!"
      render "new"
    elsif @user.password == @user.password_confirmation 
      @user.account_status = false
      if @user.save
        upload params[:user][:document]
        if params[:user][:document] == nil
          random = Random.new
          @user.update_attribute(:token_email, random.seed)
          @user.update_attribute(:medic_type_status, false)
          TemdfMailer.confimation_email(@user.id, @user.token_email, @user.email).deliver
          flash[:notice] = "Por favor confirme seu cadastro pela mensagem enviada ao seu email!"
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
      if @user.username == "admin" # Admin's update
        email = params[:user][:email]
        user_from_email = User.find_by_email(email)
        if user_from_email && @user != user_from_email
          flash[:alert] = "Email já existente"
          render "edit" 
        else 
          @user.update_attribute(:email , email)
          redirect_to root_path, notice: 'Usuário alterado!'
        end
      else # Commom user's update 
        username = params[:user][:username]
        email = params[:user][:email]
        user_from_username = User.find_by_username(username)
        user_from_email = User.find_by_email(email)
        if user_from_username && @user != user_from_username
          flash[:alert] = "Nome já existente"
          render "edit"
        elsif user_from_email && @user != user_from_email
          flash[:alert] = "Email já existente"
          render "edit" 
        else 
          @user.update_attribute(:username , username)
          @user.update_attribute(:email , email)
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
    if @user_session
        @user = User.authenticate(@user_session.username, params[:user][:password])
        new_password = params[:user][:new_password]
        if params[:user][:password_confirmation] == new_password && !new_password.blank?
          @user.update_attribute(:password, new_password)
          redirect_to root_path, notice: "Alteração feita com sucesso"
        else
          redirect_to edit_password_path, alert: "Confirmação nao confere ou campo vazio"
        end
    else
      redirect_to edit_password_path
    end
  end

  # Method to desactivate a user
  def desactivate
    @user = User.find_by_id(session[:remember_token])
    if @user && @user.username != "admin"
        @user.update_attribute(:account_status, false)
        redirect_to logout_path
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