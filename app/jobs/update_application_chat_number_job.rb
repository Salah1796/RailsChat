require 'sidekiq-scheduler'
class UpdateApplicationChatNumberJob 
  include Sidekiq::Worker
  def perform()
    Application.update_application_chats_count()
  end
end
