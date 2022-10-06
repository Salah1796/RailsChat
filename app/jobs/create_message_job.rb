class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(body,application_token,chat_number)
   CreateMessage.new(body,application_token,chat_number).create()
  end
end
