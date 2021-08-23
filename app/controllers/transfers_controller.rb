class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy ]
  before_action :set_sklads

  # GET /transfers
  def index
    @transfers = Transfer.all
  end

  # GET /transfers/1
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  def create
    @transfer = Transfer.new(transfer_params)

    if @transfer.save
      render :edit
    else
      render :new
    end
  end

  # PATCH/PUT /transfers/1
  def update
    ActiveRecord::Base.transaction do
      @transfer.products ||= []
      if params["products"]
        params["products"].each do |product_id|
          @transfer.src.product_get( product_id, params["quantify"][product_id].to_i )
          @transfer.dst.product_add( product_id, params["quantify"][product_id].to_i )
          @transfer.products << "#{product_id}-#{params["quantify"][product_id]}"
          @transfer.save!
        end
      else
        @transfer.errors.add('product_id', t('product_not_selected') )
      end

      raise ActiveRecord::Rollback if @transfer.errors.any? or @transfer.errors.any?
      @transfer.transfer!
    rescue StandardError => e
      @transfer.fail! if @transfer.may_fail?
    end

    if @transfer.transferred?
      redirect_to sklad_path(@transfer.dst), notice: t('transfer_ok')
    else
      render :edit
    end
  end

  # DELETE /transfers/1
  def destroy
    @transfer.destroy
    redirect_to transfers_url, notice: 'Transfer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.require(:transfer).permit(:product_id, :src_sklad, :dst_sklad, :quantify)
    end

    def set_sklads
      @sklads = Sklad.all
    end
end
 #{"authenticity_token"=>"[FILTERED]", "products"=>["2", "4"], "quantify"=>{"2"=>"3", "3"=>"0", "4"=>"3", "5"=>"0"}