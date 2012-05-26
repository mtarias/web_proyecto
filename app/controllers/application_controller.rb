# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  before_filter :set_locale_and_time_zone
  before_filter :set_cache_buster
  
  def require_login
  	unless session[:user_id]
		  redirect_to :root, :notice => "Debes hacer login antes de poder ver esa sección"
  	end
  end

  def set_locale_and_time_zone
  	I18n.locale = User.find(session[:user_id]).locale || I18n.default_locale
    Time.zone = User.find(session[:user_id]).time_zone
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
