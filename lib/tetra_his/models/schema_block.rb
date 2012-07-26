module Earlydoc
  module Tetra    
    class SchemaBlock
      attr_accessor :id, :name
      
      def initialize(params={})
        @id = params['Id']
        @name = params['Naam']        
      end
      
      def to_xml
        "<SchemaBlok>" +
        "<Naam>#{name}</Naam>" +
        "<Id>#{id}</Id>" +
        "</SchemaBlok>"
      end      
    end
  end
end