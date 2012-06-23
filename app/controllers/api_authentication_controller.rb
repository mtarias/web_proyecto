class ApiAuthenticationController < ApplicationController
	respond_to :json
	skip_before_filter :authenticate_api

	def create
		logger.info params.inspect
		if @user = User.login(params[:email], params[:password])
			respond_with @user
		else
			head :forbidden
		end
	end
end
