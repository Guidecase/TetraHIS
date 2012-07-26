module Earlydoc
  module Tetra
    class Response
      attr_reader   :raw
      attr_accessor :data
      
      def initialize(http_response)
        @raw = http_response
      end
      
      def error?
        @has_error ||= raw && raw.to_s.match(/ErrorCode>[1-9]/) ? true : false
      end
      
      def error_code
        error? ? raw.to_s[/ErrorCode>(.*?)</, 0].to_s : nil
      end
      
      def error_message
        error? ? raw.to_s[/ErrorString>(.*?)</, 0].to_s : nil
      end
      
      def xml
        if raw && raw.respond_to?(:body)
          XML::Parser.string(raw.body).parse
        else
          raw
        end
      end
      
      def hash
        Hash.from_libxml(raw.body)
      end
    end
  end    
end