class Chat < ApplicationRecord
    belongs_to :application  , optional: true
    validates :application_id, presence: true
    has_many :messages
    def as_json(*)
    super.except("id","application_id")
    end
    
    def self.get_chat_number(application_token)
        chat_number = nil
        last_chat  = Application.lock.select("max(Number) as Number")
                     .joins(:chats)
                     .where(applications: {token: application_token})
                     .first
        if last_chat.nil?
           chat_number = nil
        elsif last_chat.Number.nil? 
          chat_number = 0;
        else  
          chat_number  = last_chat.Number+1 
        end
      return chat_number 
    end

    def self.get_chat_by_application_token_and_chat_number(application_token,chat_number)
       chat  = Chat.joins('INNER JOIN applications ON chats.application_id = applications.id')
       .where(applications: {token: application_token})
       .find_by(["Number = :chat_number", {chat_number:chat_number}])
       return chat
     end
     def self.get_chat_id_by_app_token_and_chat_number(application_token,chat_number)
       chat  = Chat.select("id")
      .joins(:application)
      .where(applications: {token: application_token})
      .find_by(["Number = :chat_number", {chat_number:chat_number}])
      return chat.nil? ? nil : chat.id 
    end
    def self.update_chat_messages_count
      ActiveRecord::Base.connection.execute("update chats set messages_count = (select count(*) from  messages where messages.chat_id = chats.id);")
   end
end
