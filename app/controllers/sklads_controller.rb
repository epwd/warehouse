class SkladsController < ApplicationController
  before_action :set_sklad, only: [:show, :edit, :update, :destroy]
  before_action :set_regions

  # GET /sklads
  def index
    @sklads = Sklad.all
  end

  # GET /sklads/1
  def show
  end

  # GET /sklads/new
  def new
    @sklad = Sklad.new
  end

  # GET /sklads/1/edit
  def edit
  end

  # POST /sklads
  def create
    @sklad = Sklad.new(sklad_params)

    if @sklad.save
      redirect_to @sklad, notice: 'Sklad was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sklads/1
  def update
    if @sklad.update(sklad_params)
      redirect_to @sklad, notice: 'Sklad was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sklads/1
  def destroy
    @sklad.destroy
    redirect_to sklads_url, notice: 'Sklad was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sklad
      @sklad = Sklad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sklad_params
      params.require(:sklad).permit(:name, :region)
    end

    def set_regions
      @regions = Region.select(:name).map(&:name).uniq.sort
    end
end
