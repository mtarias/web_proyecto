class GuestsController < ApplicationController
	def create
    @user = User.find(params[:user_id])
    @guest = @user.guest.create(params[:guest])
    redirect_to user_path(@user)
  end
end
