class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  before_action :set_sklad, only: [:new, :create]
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
  def create( delivery=nil,delivered=false )
    # Cancle all if error 
    ActiveRecord::Base.transaction do
      prepare_params.each do |prepared_params| 
        @delivery = Delivery.new(prepared_params.merge({ consignment: Time.now.to_i }))
        if @delivery.valid?
          @delivery.save 
          MakeDeliveryWorker.perform_at( @delivery.date_time, delivery.id )
          delivered = true
        else
          delivered = false
          raise ActiveRecord::Rollback
        end
      end
    end 

    if delivered # one of..
      redirect_to deliveries_url, notice: t('delivery_ok')
    else
      redirect_to new_sklad_delivery_path(@sklad.id), notice: flash_error_message(@delivery)
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

      if params["products"]
        params["products"].each do |product_id|
          # some methods from concerns
          deliveries.push({
            date_time:  date_time(product_id), 
            product_id: product_id.to_i,
            sklad_id:   sklad_id,
            quantify:   quantify(product_id),
            aasm_state: 'inprocess'
          }) 
        end
      else
        @delivery = Delivery.new()
        @delivery.errors.add(t('products'), t('not_products'))
      end

      return deliveries
    end

    def make_delivered delivery
      {
        name: delivery.product.name,
        quantify: delivery.quantify,
        created_at: delivery.created_at,
        date_time: l(delivery.date_time,  :format => "%d %B %Y - %H:%M")
      }
    end

    def flash_error_message(arg)
      "#{arg.errors.count} : #{arg.errors.full_messages.join(', ')}"       
    end
end
