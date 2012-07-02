class PicturesController < ApplicationController

  layout 'login' , :except => :show
  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
    @event = Event.find(params[:event_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @picture = Picture.new
    @event = Event.find(params[:event_id])
    @picture.event = @event
    @picture.is_avatar = params[:is_avatar]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(Picture.picture_upload(params)[:picture])

    respond_to do |format|
      if @picture.save
        format.html { redirect_to pictures_url(:event_id => @picture.event.id) , notice: 'Picture was successfully created.' }
        format.json { render json: @picture, status: :created, location: @picture }
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(Picture.picture_upload(params)[:picture])
        format.html { redirect_to pictures_url(:event_id => @picture.event.id), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @event = Event.find(@picture.event.id)
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url(:event_id => @event.id) }
      format.json { head :no_content }
    end
  end
end
