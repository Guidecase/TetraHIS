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
    
      attr_reader :auth
    
      def initialize(base_uri, username, password)
        self.class.base_uri base_uri
        @auth = { :username => username, :password => password }
      end
      
      def rpc(method_name, *xml_nodes, &block)
        response = request method_name, xml_nodes
        response.data = []
        yield response if block_given? && !response.error?
        response
      end
    
      def request(method_name, *xml_nodes)
        xml = request_xml(method_name)
        xml_nodes.each { |node| xml.root << node }
        options = {:XML => encoded_xml(xml)}
        
        Earlydoc::Tetra::Response.new self.class.post '/', :body => options
      end
          
      private
    
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