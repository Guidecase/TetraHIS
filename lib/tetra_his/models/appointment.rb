module Earlydoc
  module Tetra    
    class Appointment
      attr_accessor :id, :begin, :end
      
      def initialize(params={})
        @id = params['Id']    
        @begin = params['Van']
      end      
      
      def to_xml
        "<PatientAfspraak>" +
        "<Id>#{self.id}</AgendaId>" +
        "<Van>#{self.begin}</Van>" +
        "</PatientAfspraak>"
      end
    end
  end
end