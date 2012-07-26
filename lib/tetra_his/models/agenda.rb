module Earlydoc
  module Tetra
    class Agenda
      attr_accessor :id, :name
  
      def initialize(params={})
        @name = params['Naam']
        @id = params['AgendaId']    
      end
    
      def to_xml
        "<AgendaOmschrijving>" +
        "<AgendaId>#{id}</AgendaId>" +
        "<Naam>#{name}</Naam>" +
        "</AgendaOmschrijving>"
      end        
    end    
  end
end