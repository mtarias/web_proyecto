# encoding: utf-8
class HomeController < ApplicationController
layout 'home', :except => :profile
layout 'login', :only => :profile
skip_before_filter :require_login
skip_before_filter :set_locale_and_time_zone, :except => :profile

  def index
    if session[:user_id]
      redirect_to profile_path
    end
  end

  #Maneja el formulario de login
  def login
  	if user = User.login(params[:user][:email],params[:user][:password])
  		session[:user_id] = user.id
  		redirect_to profile_path, :notice => "Hola de nuevo, #{user.email}!"
  	else
  		redirect_to :root, :notice => "Email o contraseña incorrecta"
  	end
  end

  def profile
  	@user = User.find(session[:user_id])
    
    news_size = 4;
    @last_updates = Array.new
    events = @user.events

    e = 0
    while @last_updates.length<5 && e<events.length do
      # Selecciono un evento con comentarios
      begin
        comments = events[e].event_comments
        e = e+1
      end while comments.blank? && e<events.length

      # Lo agrego ssi es válido
      last_comment = comments.last
      unless last_comment.blank?
        @last_updates << last_comment
      end
    end

  end

  def logout
    reset_session
  	redirect_to :root, :notice => "Has cerrado sesión correctamente"
  end
end
