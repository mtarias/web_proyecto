class TaxesController < ApplicationController
  # GET /taxes/new
  # GET /taxes/new.json
  def new
    @taxis = Tax.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @taxis }
    end
  end

  # POST /taxes
  # POST /taxes.json
  def create
    @event = Event.find(params[:event_id])
    @tax = @event.taxes.create(params[:tax])

    redirect_to @event, notice: 'Tax was successfully created.'
  end

  # DELETE /taxes/1
  # DELETE /taxes/1.json
  def destroy
    @event = Event.find(params[:event_id])
    @tax = @event.taxes.find(params[:id])
    @tax.destroy

    redirect_to @event
  end
end
