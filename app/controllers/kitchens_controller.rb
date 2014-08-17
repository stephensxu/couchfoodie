class KitchensController < ApplicationController
  before_action :set_kitchen, only: [:show, :edit, :update, :destroy]
  before_action :current_user

  # GET /kitchens
  # GET /kitchens.json
  def index
    @kitchens = Kitchen.order('created_at DESC')
    if logged_in?
      redirect_to users_path
    else
      render :index
    end
  end

  # GET /kitchens/1
  # GET /kitchens/1.json
  def show
  end

  # GET /kitchens/new
  def new
    @kitchen = Kitchen.new
  end

  # GET /kitchens/1/edit
  def edit
  end

  # POST /kitchens
  # POST /kitchens.json
  def create
    @kitchen = Kitchen.new(kitchen_params)
    @kitchen.user = current_user

    if @kitchen.save
      redirect_to root_url, notice: 'Kitchen was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kitchens/1
  # PATCH/PUT /kitchens/1.json
  def update
    respond_to do |format|
      if @kitchen.update(kitchen_params)
        format.html { redirect_to @kitchen, notice: 'Kitchen was successfully updated.' }
        format.json { render :show, status: :ok, location: @kitchen }
      else
        format.html { render :edit }
        format.json { render json: @kitchen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kitchens/1
  # DELETE /kitchens/1.json
  def destroy
    if @kitchen.editable_by?(current_user)
      @kitchen.destroy
      redirect_to kitchens_users_path, notice: 'Kitchen was successfully destroyed.'
    else
      redirect_to kitchens_users_path, notce: "you are not authroized to delete this kitchen!"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_kitchen
    @kitchen = Kitchen.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def kitchen_params
    params.require(:kitchen).permit(:name, :description, :street_address, :city,
                   :state, :zipcode)
  end
end
