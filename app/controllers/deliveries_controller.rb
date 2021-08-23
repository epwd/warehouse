class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  before_action :set_sklad, only: :new
  before_action :set_products, only: :new

  include ParamsPrepareConcern
  
  # GET /deliveries
  def index
    @deliveries = Hash.new
    Delivery.all.sort_by(&:date_time).reverse.each do |delivery|
      # for delivered column
      if @deliveries.has_key?(delivery.consignment)
        @deliveries[delivery.consignment].push( make_delivered(delivery) )
      else
        @deliveries[delivery.consignment] = [ make_delivered(delivery) ]
      end
    end
  end

  # GET /deliveries/1
  def show
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
  end

  # GET /deliveries/1/edit
  def edit
  end

  # POST /deliveries
  def create(delivery=nil)
    prepare_params.each do |prepared_params| 
      delivery = Delivery.create(prepared_params.merge({ consignment: Time.now.to_i }))
      MakeDeliveryWorker.perform_at( delivery.date_time, delivery.id )
    end
    if delivery # one of..
      redirect_to deliveries_url, notice: t('delivery_ok')
    else
      render :new
    end
  end

  # PATCH/PUT /deliveries/1
  def update
    if @delivery.update(delivery_params)
      redirect_to @delivery, notice: 'Delivery was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /deliveries/1
  def destroy
    @delivery.destroy
    redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def delivery_params
      params.require(:delivery).permit(:date, :product_id, :sklad_id, :quantify, :aasm_state)
    end

    def set_sklad
      @sklad = Sklad.find(params[:sklad_id])
    end

    def set_products
      @products = Product.all
    end

  protected
    def prepare_params
      deliveries = []
      params["products"].each do |product_id|
        # some methods from concerns
        deliveries.push({
          date_time: date_time(product_id), 
          product_id: product_id.to_i,
          sklad_id: sklad_id,
          quantify: quantify(product_id),
          aasm_state: 'inprocess'
        })
      end
      deliveries
    end

    def make_delivered delivery
      {
        name: delivery.product.name,
        quantify: delivery.quantify,
        created_at: delivery.created_at,
        date_time: l(delivery.date_time,  :format => "%d %B %Y - %H:%M")
      }
    end
end
