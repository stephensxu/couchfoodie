class KitchensController < ApplicationController
  before_action :set_kitchen, :only => [:show, :edit, :update, :destroy, :reservations_pending,
                :reservations_approved, :reservations_denied]
  before_action :require_authorization!, :only => [:edit, :update, :destroy, :reservations_pending,
                :reservations_approved, :reservations_denied]
  before_action :total_pending_reservations

  # GET /kitchens
  # GET /kitchens.json
  def index
    if logged_in?
      redirect_to users_path
    else
      render :index
    end
  end

  def reservations_pending
    @kitchen = Kitchen.find(params[:id])
    @reservations = @kitchen.reservations.pending
    render :kitchen_reservations_pending
  end

  def reservations_approved
    @kitchen = Kitchen.find(params[:id])
    @reservations = @kitchen.reservations.approved
    render :kitchen_reservations_approved
  end

  def reservations_denied
    @kitchen = Kitchen.find(params[:id])
    @reservations = @kitchen.reservations.denied
    render :kitchen_reservations_denied
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
    head(:forbidden) unless @kitchen.editable?
  end

  # POST /kitchens
  # POST /kitchens.json
  def create
    @kitchen = Kitchen.new(kitchen_params)
    @kitchen.user = current_user

    if @kitchen.save
      redirect_to kitchens_users_path, notice: 'Kitchen was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kitchens/1
  # PATCH/PUT /kitchens/1.json
  def update
    if @kitchen.update(kitchen_params)
      redirect_to kitchens_users_path, notice: 'Kitchen was succesfully updated'
    else
      render :edit
    end
  end

  # DELETE /kitchens/1
  # DELETE /kitchens/1.json
  def destroy
    @kitchen.archive!
    redirect_to kitchens_users_path, notice: 'Kitchen was succesfully deleted'
  end

  private

  def require_authorization!
    head(:forbidden) unless @kitchen.editable_by?(current_user)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_kitchen
    @kitchen = Kitchen.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def kitchen_params
    params.require(:kitchen).permit(:name, :description, :street_address, :city,
                   :state, :zipcode, :data_status)
  end

  def kitchen_selection
    params.permit(:id)
  end
end
