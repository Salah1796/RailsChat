class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :destroy,:fix]
  before_action :set_application_for_update, only: [:update]


  # GET /applications
  def index
    @applications = Application.all
    render json: @applications
  end

  # GET /applications/:application_token
  def show
    render json: @application
  end

  # POST /applications
  def create
    @application = Application.new(application_create_params)
    @application.token = SecureRandom.uuid
    if @application.save
      render json: @application.token, status: :created, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/:application_token
  def update
    if @application.update(application_update_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy
  end

   def chats
     @chats = Application.get_application_chats(params[:application_token])
     render json: @chats
   end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application =  Application.where(["token = :token", { token: params[:id]}]).first 
    end
    def set_application_for_update
      @application =  Application.lock.where(["token = :token", { token: params[:id]}]).first 
    end

    # Only allow a trusted parameter "white list" through.
    def application_create_params
      params.require(:application).permit(:name)
    end

    def application_update_params
      params.require(:application).permit(:name)
    end
end
