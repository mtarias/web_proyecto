# encoding: utf-8
class HomeController < ApplicationController
  def index
  end

  def login
  	if user = User.login(params[:user][:email],params[:user][:password])
  		session[:user_id] = user.id
  		redirect_to :root, :notice => "Hola de nuevo!"
  	else
  		redirect_to :root, :notice => "Email o contraseña incorrecta"
  	end
  end
end
