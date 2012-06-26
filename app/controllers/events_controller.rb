# encoding: utf-8
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  skip_before_filter :require_login, :only => :public_events
  layout 'login'

  def index
    redirect_to :root
  end

  def next_events
    future_events = Event.future_events
    # Agrego los eventos públicos
    @events = future_events.where(:is_private => false)
    # Agrego los eventos privados...
    private_events = future_events.where(:is_private => true)
    # ... pero a los cuales tenga invitación
    private_events.each do |event|
      if Guest.is_user_invited? session[:user_id], event.id
        @events << event
      end
    end
    
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
    @json = @event.to_gmaps4rails
    @admins = @event.admins_to_s
    @taxes = @event.taxes
    @user = User.find(session[:user_id])

    # Manejo la CheckList
    @user_commit = []
    @remaining_taxes = []

    @taxes.each do |tax|
      c = UserTax.user_commit(session[:user_id], tax.id)
      unless c.blank?
        @user_commit += c
      end
      if tax.needs_contributions?
        @remaining_taxes << tax
      end
    end

    # Manejo los invitados
    @going = []
    #@not_going = []
    @waiting_answer = []

    @event.guests.each do |invitation|
      response = invitation.is_going
      if response
        @going << invitation
      elsif response.nil?
        @waiting_answer << invitation
      #else
        #@not_going << invitation
      end
    end

    # Manejo las invitaciones. Por cambiar
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
        format.html { redirect_to @event, notice: I18n.t(:successful_new_event) }
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
    # Buscamos si existe una invitación
    @guest = Guest.get_invitation(session[:user_id], params[:id])
    # Si no existe, creamos una
    if @guest.nil?
      @guest = @event.guests.create(params[:guest])
      @guest.user_id = session[:user_id]
      @guest.is_admin = false
    end

    @guest.is_going = true
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @event, notice: I18n.t(:will_go) }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, notice: 'No funcionó D:'}
      end
    end
  end

  def not_attend
    @event = Event.find(params[:id])
    @guest = Guest.get_invitation(session[:user_id], params[:id])
    # Hay que considerar el caso en que es el único administrador

    if @guest.is_admin
      # Hay que ver si existen más administradores
      if @event.number_of_admins > 1
        @guest.is_going = false
        @guest.is_admin = false

        respond_to do |format|
          if @guest.save
            format.html { redirect_to :back, notice: I18n.t(:wont_go) }
            format.json { head :no_content }
          else
            format.html { redirect_to :back, notice: 'No funcionó D:'}
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, notice: I18n.t(:wont_go_admin_error)}
        end
      end
    else
      # Si no es admin, puede dejar de asistir sin problemas
      @guest.is_going = false

      respond_to do |format|
        if @guest.save
          format.html { redirect_to :back, notice: I18n.t(:wont_go) }
          format.json { head :no_content }
        else
          format.html { redirect_to :back, notice: 'No funcionó D:'}
        end
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
        format.html { redirect_to @event, notice: I18n.t(:successful_invitation, :email => User.find(params[:guest_id]).email) }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, notice: 'No funcionó D:'}
      end
    end
  end
  
end
