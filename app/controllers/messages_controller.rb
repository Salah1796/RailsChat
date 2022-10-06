class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]
  before_action :set_message_for_update, only: [:update]


  # GET /messages/:application_token/:chat_number/:message_number
  def show
    if  @message.nil?
        render  json: "application or  chat Not found", status: :unprocessable_entity
        else
        render json: @message.as_json(:except => [:chat_id,:id]), status: :ok
    end
  end

  # POST /messages/:application_token/:chat_number
  def create
    CreateMessageJob.perform_later(message_params[:Body],params[:application_token],params[:chat_number])
    render json: "messages created successfully", status: :created
  end
  # PUT /messages/:application_token/:chat_number/:message_number
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end
   # delete /messages/:application_token/:chat_number/:message_number
   def destroy
       @message.destroy
   end
   # GET /messages/:application_token/:chat_number/search/:query
  def search
    @messages = SearchMessage.new(params[:query],params[:application_token],params[:chat_number]).search()
    render json: @messages.as_json(:except => [:chat_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.get_message_by_application_token_chat_number_message_number(params[:application_token],params[:chat_number],params[:message_number])
    end
    def set_message_for_update
      @message = Message.lock.get_message_by_application_token_chat_number_message_number(params[:application_token],params[:chat_number],params[:message_number])
    end
    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:Body)
    end
end
