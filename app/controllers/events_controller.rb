# encoding: utf-8
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  skip_before_filter :require_login, :only => :public_events
  layout 'login'

  def next_events
    @events = Event.future_events
    respond_to do |format|
      format.html # next_events.html.erb
      format.json { render json: @events }
    end
  end

  def user_events
    @events = Array.new
    valid_events =  Event.future_events
    
    valid_events.each do |e|
      unless Guest.where(:is_admin => true).where(:user_id => session[:user_id]).where(:event_id => e.id).empty?
        @events << e
      end
    end

    respond_to do |format|
      format.html # user_events.html.erb
      format.json { render json: @events }
    end
  end

  def past_events
    @events = Array.new
    valid_events = Event.past_events

    valid_events.each do |e|
      unless Guest.where(:user_id => session[:user_id]).where(:event_id => e.id).empty?
        @events << e
      end
    end

    respond_to do |format|
      format.html # past_events.html.erb
      format.json { render json: @events }
    end
  end

  def public_events
    @events = Event.future_events.where(:is_private => false)

    respond_to do |format|
      format.html # public_events.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    @friends = nil
    unless params[:search].blank?
      @friends = User.search(params[:search])

      @event.guests.each do |g|
        @friends -= User.where(:id => g.user_id)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        @guest = @event.guests.create(params[:guest])
        @guest.user_id = session[:user_id]
        @guest.is_admin = true
        @guest.is_going = true
        @guest.save
        format.html { redirect_to @event, notice: 'Tu evento fue creado exitosamente' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Cambios guardados exitosamente' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def require_admin
    @event = Event.find(params[:id])
    @guest = event.find(params[:guest])
    unless (session[:user_id] == @guest.user.user_id)
        format.html { redirect_to @event, notice: 'Debe ser admin para editar el evento.' }
    end
  end

  def assist
    @event = Event.find(params[:id])
    @guest = @event.guests.create(params[:guest])
    @guest.user_id = session[:user_id]
    @guest.is_admin = false
    @guest.is_going = true
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @event, notice: 'Asistirás a este evento' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, notice: 'No funcionó D:'}
      end
    end
  end

def invite
    @event = Event.find(params[:id])
    @guest = @event.guests.create(params[:guest])
    @guest.user_id = params[:guest_id]
    @guest.is_admin = false
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @event, notice: 'Has invitado exitosamente' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, notice: 'No funcionó D:'}
      end
    end
  end
  
end
