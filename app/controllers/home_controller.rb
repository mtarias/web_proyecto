# encoding: utf-8
class HomeController < ApplicationController
layout 'home', :except => :profile
skip_before_filter :require_login

  def index
    if User.exists? session[:user_id]
      redirect_to profile_path
    end
  end

  #Maneja el formulario de login
  def login
  	if user = User.login(params[:user][:email],params[:user][:password])
      session[:user_id] = user.id
      # Aprovecho de cargar el idioma
      set_locale_and_time_zone
      redirect_to profile_path, :notice => I18n.t(:greet_user, :user => user.name)
  	else
  		redirect_to :root, :notice => I18n.t(:bad_login)
  	end
  end

  def profile
  	@user = User.find(session[:user_id])
    
    news_size = 5;
    @last_comments = Array.new
    events = @user.events

    e = 0
    while @last_comments.length<news_size && e<events.length do
      # Selecciono un evento con comentarios
      begin
        comments = events[e].event_comments
        e = e+1
      end while comments.blank? && e<events.length

      # Lo agrego ssi es válido
      last_comment = comments.last
      unless last_comment.blank?
        @last_comments << last_comment
      end
    end

    @last_taxes = Array.new

    # Por implementar
    e = 0
    while @last_taxes.length<news_size && e<events.length do
      # Selecciono un evento con taxes
      begin
        taxes = events[e].taxes
        e = e+1
      end while taxes.blank? && e<events.length

      # Lo agrego ssi es válido
      last_tax = taxes.last
      unless last_tax.blank?
        @last_taxes << last_tax
      end
    end

    render :layout => 'login'

  end

  def logout
    message = I18n.t(:successful_logout)
    reset_session
  	redirect_to :root, :notice => message
  end
end
