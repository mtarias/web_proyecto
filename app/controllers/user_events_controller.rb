class UserEventsController < ApplicationController
	def create
    @user = User.find(params[:user_id])
    @user_event = @user.user_events.create(params[:user_event])
    redirect_to user_path(@user)
  end
end
