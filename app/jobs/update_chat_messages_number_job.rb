require 'sidekiq-scheduler'
class UpdateChatMessagesNumberJob 
  include Sidekiq::Worker
  def perform()
    Chat.update_chat_messages_count()
  end
end
