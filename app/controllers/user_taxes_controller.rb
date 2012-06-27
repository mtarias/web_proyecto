class UserTaxesController < ApplicationController
	def create
		event_id = params[:user_tax][:event_id]
		# Necesito el event_id, pero no puedo hacer mass-assign con él en los parámetros
		params[:user_tax].delete 'event_id'
		@event = Event.find(event_id)
		user = User.find(user_id)
		@user_tax = user.user_taxes.create(params[:user_tax])
		redirect_to @event
	end

	def destroy
		@user = User.find(user_id)
		@user_tax = UserTax.find(params[:id])
		@event = @user_tax.tax.event
		@user_tax.destroy

		redirect_to @event
 	end
end
