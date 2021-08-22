class SkladProductsController < ApplicationController
  before_action :set_sklad_product, only: [:show, :edit, :update, :destroy]

  # GET /sklad_products
  def index
    @sklad_products = SkladProduct.all
  end

  # GET /sklad_products/1
  def show
  end

  # GET /sklad_products/new
  def new
    @sklad_product = SkladProduct.new
  end

  # GET /sklad_products/1/edit
  def edit
  end

  # POST /sklad_products
  def create
    @sklad_product = SkladProduct.new(sklad_product_params)

    if @sklad_product #.save
      redirect_to @sklad_product, notice: 'Sklad product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sklad_products/1
  def update
    if @sklad_product.update(sklad_product_params)
      redirect_to @sklad_product, notice: 'Sklad product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sklad_products/1
  def destroy
    @sklad_product.destroy
    redirect_to sklad_products_url, notice: 'Sklad product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sklad_product
      @sklad_product = SkladProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sklad_product_params
      params.require(:sklad_product).permit(:product_id, :sklad_id, :quantify)
    end
end
