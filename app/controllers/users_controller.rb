# encoding: utf-8
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
layout 'login', :except => [:new, :create]
skip_before_filter :require_login, :only => [:new,:create]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json # index.json.jbuilder
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json # show.json.jbuilder
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html { render :layout => 'application' } # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit_profile
    @user = User.find(session[:user_id])
    if !@user
      return redirect_to :root, :notice => "Primero debes iniciar sesión"
    end
    render 'edit'
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        # Logueamos automáticamente al usuario que acaba de crear su cuenta
        session[:user_id] = @user.id
        # Mandamos un mail de registro
        # UserMailer.welcome_email(@user).deliver
        format.html { redirect_to profile_path, notice: I18n.t(:new_user_message) }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new", layout: 'application' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
