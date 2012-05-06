# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def require_login
  	unless session[:user_id]
		redirect_to :root, :notice => "Debes hacer login antes de poder ver esa sección"
  	end
  end
end
