class CreateMessage
    def initialize(body,application_token,chat_number)
        @application_token = application_token
        @chat_number =chat_number
        @body =body
    end
  
    def create()
      message_number = 0;
      chat  = Chat.get_chat_by_application_token_and_chat_number(@application_token,@chat_number)
       if(!chat.nil?) 
        message = Message.new()
        message.Body = @body
        message.chat_id = chat.id
        last_message  = Message.lock.select("Number")
       .where(["chat_id = :chat_id", { chat_id: chat.id}])
       .order('Number DESC')
       .first
       message_number =  last_message.nil? ? 1 : last_message.Number+1
       message.Number = message_number 
       message.save
       ActionCable.server.broadcast("message", message.as_json(:except => [:id,:chat_id]))
       end
      return message_number
    end
  end