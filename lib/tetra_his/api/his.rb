module Earlydoc
  module Tetra
    class HIS
      include Earlydoc::Tetra::TetraXmlDate
      include Earlydoc::Tetra::AgendaMethods
      include Earlydoc::Tetra::AppointmentMethods
      include Earlydoc::Tetra::PatientMethods
      include HTTParty
    
      XSI = 'http://www.w3.org/2001/XMLSchema-instance'
      XSD = 'http://www.w3.org/2001/XMLSchema'
    
      format :plain
      default_timeout 30
    
      attr_reader :auth, :debug
    
      def initialize(base_uri, username, password, debug=false)
        self.class.base_uri base_uri
        @auth = { :username => username, :password => password }
        @debug = debug
      end
      
      def rpc(method_name, *xml_nodes, &block)
        response = request method_name, xml_nodes
        response.data = []
        begin
          yield response if block_given? && !response.error?
        rescue NoMethodError => e
          raise e unless is_data_parsing_error?(e.message)
        end
        response
      end
    
      def request(method_name, *xml_nodes)
        xml = request_xml(method_name)
        xml_nodes.flatten.each { |node| xml.root << node }
        options = {:XML => encoded_xml(xml)}

        if @debug
          p "XML REQUEST:"
          p xml
        end
        
        begin
          Earlydoc::Tetra::Response.new self.class.post '/', :body => options
        rescue Errno::EHOSTUNREACH
          Earlydoc::Tetra::Response.new "<ErrorString>Unreachable host</ErrorString><ErrorCode>1</ErrorCode>"
        rescue Errno::ECONNREFUSED
          Earlydoc::Tetra::Response.new "<ErrorString>Bad connection</ErrorString><ErrorCode>1</ErrorCode>"
        end
      end
          
      private
      
      def is_data_parsing_error?(message)
        message && message.include?("undefined method `[]' for nil:NilClass")
      end
    
      def encoded_xml(xml_doc)
        xml_doc.to_s(:indent => false)
      end
    
      def request_xml(rpc_method)
        doc = XML::Document.new
        doc.encoding = XML::Encoding::UTF_8
        doc.root = XML::Node.new(rpc_method)
        doc.root['xmlns'] = ''
        doc.root['xmlns:xsi'] = Earlydoc::Tetra::HIS::XSI
        doc.root['xmlns:xsd'] = Earlydoc::Tetra::HIS::XSD
              
        doc.root << XML::Node.new('Installation')
        doc.root << un_node = XML::Node.new('Username')
        doc.root << pw_node = XML::Node.new('Password')
        un_node << auth[:username]
        pw_node << auth[:password]
        doc
      end        
    end
  end
end