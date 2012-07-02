# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  skip_before_filter :verify_autheticate_token, if: :is_api_request?
  before_filter :set_locale_and_time_zone
  before_filter :set_cache_buster
  
  def require_login
    logger.info "Hola api_key: '#{params[:api_key]}'"
  	if is_api_request?
      # Si se llama a la API verifico su key
      if User.where(:api_key => params[:api_key]).blank?
        head :forbidden
        return false
      end
    elsif !User.exists?(session[:user_id])
      # Si no es a la API, verifico que el usuario haya iniciado sesión
		  redirect_to :root, :notice => "Debes hacer login antes de poder ver esa sección"
  	end
  end

  def set_locale_and_time_zone
    u = User.where(:id => user_id).first
    if u
      I18n.locale = u.locale
      Time.zone = u.time_zone
    else
      I18n.locale = extract_locale_from_accept_language_header
    end
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def user_id
    u = User.find_by_api_key(params[:api_key])
    session[:user_id] || u ? u.id : nil
  end

  private
  def extract_locale_from_accept_language_header
    user_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first

    supported_locales = ["es-CL", "en"]
    
    givme_the_best_locale supported_locales, user_locale
  end

  def givme_the_best_locale(list, user_locale)
    logger.info "El user_locale es: '#{user_locale}'"
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
