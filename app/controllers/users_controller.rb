# encoding: utf-8
class UsersController < ApplicationController
  layout 'login', :except => [:new, :create]
  skip_before_filter :require_login, :only => [:new,:create]
  respond_to :html, :json

  def index
    @users = User.all

    respond_with @users
  end

  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  # GET /users/new.json
  def new
    @user = User.new

    respond_with @user, :layout => 'application'
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        # Logueamos automáticamente al usuario que acaba de crear su cuenta
        session[:user_id] = @user.id
        # Mandamos un mail de registro
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to profile_path, notice: I18n.t(:new_user_message) }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new", layout: 'application' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Tus datos fueron guardados exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :no_content }
    end
  end

end
