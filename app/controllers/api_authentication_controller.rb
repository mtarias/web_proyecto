class ApiAuthenticationController < ApplicationController
	respond_to :json
	skip_before_filter :require_login
	skip_before_filter :set_locale_and_time_zone

	def create
		logger.info params.inspect
		if @user = User.login(params[:email], params[:password])
			respond_with @user
		else
			head :forbidden
		end
	end
end
