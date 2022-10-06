class Message < ApplicationRecord
    belongs_to :chat ,   optional: true
    validates :Body, presence: true
    validates :chat_id, presence: true
    include Searchable
    def self.get_chat_messages(application_token,chat_number)
      messages = Message.joins(chat: :application)
      .where(chats: {Number: chat_number})
      .where(applications: {token: application_token})
      return messages
    end  

    def self.get_message_by_application_token_chat_number_message_number(application_token,chat_number,message_number)
       message = Message.joins(chat: :application)
      .where(chats: {Number: chat_number})
      .where(applications: {token: application_token})
      .find_by(["messages.Number = :message_number", {message_number:message_number}])
      return message
     end
end
