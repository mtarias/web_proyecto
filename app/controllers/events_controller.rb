class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  layout 'login'
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

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
        @guest.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
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
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @event, notice: 'Asistiras a este evento' }
        format.json { head :no_content }
      else
        format.html { redirect_to publicevent, notice: 'No funciono D:'}
      end
    end
  end
  
end
