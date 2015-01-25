class ConventionsController < ApplicationController
 
  def index
    @convention = Convention.all
  end
  def new
    @convention = Convention.new
    delivery = @convention.delivery.build
  end
  def update
    @convention = Convention.find(params[:id])
    respond_to do |format|
      if @convention.update_attributes(convention_params)
        format.html { redirect_to @convention, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @convention }
      else
        format.html { render :edit }
        format.json { render json: @convention.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @convention = Convention.new(convention_params)

    respond_to do |format|
      if @convention.save
        format.html { redirect_to @convention, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @convention }
      else
        format.html { render :new }
        format.json { render json: @convention.errors, status: :unprocessable_entity }
      end
    end
  end
    # Never trust parameters from the scary internet, only allow the white list through.
  def convention_params
    params.require(:convention).permit(:libelle)
    end
  def show
    @convention = Convention.find(params[:id])
  end
  def edit
    @convention = Convention.find(params[:id])
  end

end
