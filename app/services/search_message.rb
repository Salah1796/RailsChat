require 'json'
class SearchMessage
    def initialize(query,application_token,chat_number)
        @application_token = application_token
        @chat_number =chat_number
        @query =query
    end
  
    def search()
        messages = nil
        chat_id = Chat.get_chat_id_by_app_token_and_chat_number(@application_token,@chat_number)
        query_rgex = ".*"+@query+".*"
        
        if !chat_id.nil? 
          params = {
            query: {
              bool: {
                must: [
                  {
                    regexp: {
                      Body: query_rgex,
                    },
                  },
                ],
                filter: [
                  {
                    term: { chat_id: chat_id }
                  }
                ]
              }
            }
          }
    
        result = Message.search(params)
        messages = result.response["hits"]["hits"]
        end
        return messages.map{|message| message._source  } 
        end
  end