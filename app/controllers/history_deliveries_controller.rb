class HistoryDeliveriesController < ApplicationController
  before_action :set_history_delivery, only: [:show, :edit, :update, :destroy]

  # GET /history_deliveries
  def index
    @history_deliveries = HistoryDelivery.all
  end

  # GET /history_deliveries/1
  def show
  end

  # GET /history_deliveries/new
  def new
    @history_delivery = HistoryDelivery.new
  end

  # GET /history_deliveries/1/edit
  def edit
  end

  # POST /history_deliveries
  def create
    @history_delivery = HistoryDelivery.new(history_delivery_params)

    if @history_delivery.save
      redirect_to @history_delivery, notice: 'History delivery was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /history_deliveries/1
  def update
    if @history_delivery.update(history_delivery_params)
      redirect_to @history_delivery, notice: 'History delivery was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /history_deliveries/1
  def destroy
    @history_delivery.destroy
    redirect_to history_deliveries_url, notice: 'History delivery was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history_delivery
      @history_delivery = HistoryDelivery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def history_delivery_params
      params.require(:history_delivery).permit(:delivered)
    end
end
