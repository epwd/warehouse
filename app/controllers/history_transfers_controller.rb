class HistoryTransfersController < ApplicationController
  before_action :set_history_transfer, only: [:show, :edit, :update, :destroy]

  # GET /history_transfers
  def index
    @history_transfers = HistoryTransfer.all
  end

  # GET /history_transfers/1
  def show
  end

  # GET /history_transfers/new
  def new
    @history_transfer = HistoryTransfer.new
  end

  # GET /history_transfers/1/edit
  def edit
  end

  # POST /history_transfers
  def create
    @history_transfer = HistoryTransfer.new(history_transfer_params)

    if @history_transfer.save
      redirect_to @history_transfer, notice: 'History transfer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /history_transfers/1
  def update
    if @history_transfer.update(history_transfer_params)
      redirect_to @history_transfer, notice: 'History transfer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /history_transfers/1
  def destroy
    @history_transfer.destroy
    redirect_to history_transfers_url, notice: 'History transfer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history_transfer
      @history_transfer = HistoryTransfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def history_transfer_params
      params.require(:history_transfer).permit(:src, :dst, :transferred)
    end
end
