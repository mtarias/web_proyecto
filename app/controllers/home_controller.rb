# encoding: utf-8
class HomeController < ApplicationController
layout 'home', :except => :profile
layout 'login', :only => :profile

  def index
    if session[:user_id]
      redirect_to profile_path
    end
  end

  def login
  	if user = User.login(params[:user][:email],params[:user][:password])
  		session[:user_id] = user.id
  		redirect_to profile_path, :notice => "Hola de nuevo, #{user.email}!"
  	else
  		redirect_to :root, :notice => "Email o contraseña incorrecta"
  	end
  end

  def profile
  	if params[:email]
  		if user = User.find_by_email(params[:email])
  			@user = user
  		else
  			redirect_to :root, :notice => "No existe usuario con ese email"
  		end
  	elsif session[:user_id]
  		@user = User.find(session[:user_id])
  	else
  		redirect_to :root, :notice => "Inicie sesión nuevamente"
  	end
  end

  def logout
    @user = nil
  	reset_session
  	redirect_to :root, :notice => "Has cerrado sesión correctamente"
  end
end
