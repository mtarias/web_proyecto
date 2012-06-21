# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  skip_before_filter :verify_autheticate_token, if: :is_api_request?
  before_filter :authenticate_api
  before_filter :set_locale_and_time_zone
  before_filter :set_cache_buster
  
  def require_login
  	unless User.exists? session[:user_id]
		  redirect_to :root, :notice => "Debes hacer login antes de poder ver esa sección"
  	end
  end

  def authenticate_api
    if is_api_request?
      unless User.where(:api_key => params[:api_key]).first
        head :forbidden
        return false
      end
    end
  end

  def set_locale_and_time_zone
  	if User.exists? session[:user_id]
      I18n.locale = User.find(session[:user_id]).locale
      Time.zone = User.find(session[:user_id]).time_zone
    else
      I18n.locale = extract_locale_from_accept_language_header
    end
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  private
  def extract_locale_from_accept_language_header
    user_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first

    supported_locales = ["es-CL", "en"]
    
    givme_the_best_locale supported_locales, user_locale
  end

  def givme_the_best_locale(list, user_locale)
    list.each do |locale|
      if locale.include? user_locale
        return locale
      end
    end
    I18n.default_locale
  end

  def is_api_request?
    request.format.json?
  end
end
