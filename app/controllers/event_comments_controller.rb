class EventCommentsController < ApplicationController
	def create
	    @event = Event.find(params[:event_id])
	    @event_comment = @event.event_comments.create(params[:event_comment])
	    @event_comment.user_id = user_id
	    @event_comment.save
	    redirect_to event_path(@event)
	  end
	  def destroy
	    @event = Event.find(params[:event_id])
	    @event_comment = @event.event_comments.find(params[:id])
	    @event_comment.destroy
	    redirect_to event_path(@event)
	  end
end
