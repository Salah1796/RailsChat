class CreateChat
    def initialize(application_token)
        @application_token = application_token
    end
    def create()
      chat_number = 0 
      application_id =  Application.get_application_id_by_token(@application_token);
      if !application_id.nil? 
      chat = Chat.new()
      chat.application_id = application_id
      chat_number = Chat.get_chat_number(@application_token)
      caht.Number = chat_number
      chat.save
      ActionCable.server.broadcast("chat", chat.as_json(:except => [:id,:application_id]))
      end
      return chat_number
    end
  end