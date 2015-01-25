class DeliveriesController < ApplicationController
  #autocomplete :convention, :libelle, :scopes => [:conventionuser]
  autocomplete :convention, :libelle
  # GET /deliveries/new
  def new
    @delivery = Delivery.new
  end
  def index
    @delivery = Delivery.all
  end
  def show
    set_delivery
  end
  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = Delivery.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to @delivery, notice: 'Le Livrable a bien été crée' }
        format.json { render :show, status: :created, location: @delivery }
      else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def delivery_params
    params.require(:delivery).permit(:libelle, :convention_id)
  end

end
