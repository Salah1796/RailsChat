class CreateChatJob < ApplicationJob
    queue_as :default
  
    def perform(application_token)
      CreateChat.new(application_token).create()
    end
  end
  