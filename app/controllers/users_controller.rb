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
        # UserMailer.welcome_email(@user).deliver
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
      @user.name = params[:user][:name]
      @user.email = params[:user][:email]
      @user.time_zone = params[:user][:time_zone]
      @user.locale = params[:user][:locale]

      unless params[:user][:password].blank?
        @user.password = params[:user][:password]
      end
      if @user.save
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

  def search
    # Para el manejo de las invitaciones
    event = Event.find(params[:event_id])

    unless params[:q].blank?
      users = User.search(params[:q])

      event.guests.each do |g|
        users -= User.where(:id => g.user_id)
      end
      if users.blank? && !(params[:q])[/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i].nil?
        # En el caso de que sea un email válido
        u = User.new
        u.name = params[:q]
        u.email = params[:q]
        users = [u]
      end
    else
      # Solo respondo si se ha enviado un string no vacío
      users = []
    end

    render :json => users.collect {|u| { :id => u.id, :name => u.name, :email => u.email } }
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    if user_id && @user == User.find(user_id)
      @user = false
    end

    render :json => !@user
  end

  def search_group
    # Para el manejo de los grupos
    group = Group.find(params[:group_id])

    unless params[:q].blank?
      users = User.search_group(params[:q])

      group.group_members.each do |g|
        users -= User.where(:id => g.user_id)
      end
      if users.blank? && !(params[:q])[/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i].nil?
        # En el caso de que sea un email válido
        u = User.new
        u.name = params[:q]
        u.email = params[:q]
        users = [u]
      end
    else
      # Solo respondo si se ha enviado un string no vacío
      users = []
    end

    render :json => users.collect {|u| { :id => u.id, :name => u.name, :email => u.email } }
  end


end
