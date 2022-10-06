class ChatsController < ApplicationController
   before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats/:application_token/:chat_number
  def show
    if  @chat.nil?
        render  json: "application or chat Not found", status: :unprocessable_entity
        else
        render json:  @chat, status: :ok
    end
  end
  # POST /chats/:application_token
  def create
    CreateChatJob.perform_later(params[:application_token])
    render json: "chat created successfully", status: :created
    
    #if we need to return chat number we must perform saving chat  without sidekiq
    # as it dependes on last created chat 
    # caht_number =   CreateChat.new(params[:application_token]).create()
    # render json: caht_number, status: :created

  end
  # GET chats/:application_token/:chat_number/messages
  def messages
    messages = Message.get_chat_messages(params[:application_token],params[:chat_number])
    if  messages.nil?
        render  json: "application_token or chat Not found", status: :unprocessable_entity
        else
         render json: messages.as_json(:except => [:chat_id,:id]), status: :ok
    end
  end
  # DELETE /chats/:application_token/:chat_number
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.get_chat_by_application_token_and_chat_number(params[:application_token],params[:chat_number])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:Number)
    end
end
