# encoding: utf-8
class HomeController < ApplicationController
layout 'home', :except => :profile
layout 'login', :only => :profile

  def index
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
  			redirect_to :root, :notice => "No existe usuario con ese email, weon"
  		end
  	elsif session[:user_id]
  		@user = User.find(session[:user_id])
  	else
  		redirect_to :root, :notice => "No existe usuario con ese email, aweonao"
  	end
  end

  def logout
  	reset_session
  	redirect_to :root, :notice => "Has cerrado sesión correctamente"
  end
end
