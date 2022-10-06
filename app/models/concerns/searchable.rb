module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
  
      def as_indexed_json(options = {})
         self.as_json(only: [:Body, :chat_id,:Number,:created_at,:updated_at])
      end
      mapping do
        indexes :Body, type: :text
        indexes :chat_id, type: :keyword
        indexes :Number, type: :keyword
        indexes :created_at, type: :keyword
        indexes :updated_at, type: :keyword
      end
  
      def self.search(query)
        self.__elasticsearch__.search(query)
      end
    end
  end