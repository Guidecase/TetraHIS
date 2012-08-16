module Earlydoc
  module Tetra  
    class Slot
      include Earlydoc::Tetra::TetraXmlDate
      
      attr_accessor :id, :agenda_id, :begin, :end, :available, :doctor
  
      def initialize(params={})
        @id = params['Identifier']
        @agenda_id = params['AgendaID']
        @begin = params['DateTime']
        @end = params['TimeTill']
        @available = params['Available']
        @doctor = params['Doctor']
      end        
      
      def time
        "#{self.begin.strftime('%A %d, %I:%M %p')}-#{self.end.strftime('%I:%M %p')}" if self.begin && self.end
      end
      
      def to_xml
        "<AppointmentSlot>" +
        "<DateTime>#{format_date(self.begin, '%Y-%m-%dT%H:%M:00')}</DateTime>" +
        "<TimeTill>#{format_date(self.end, '%Y-%m-%dT%H:%M:00')}</TimeTill>" +
        "<Doctor>#{doctor}</Doctor>" +
        "<AgendaID>#{agenda_id}</AgendaID>" +
        "<Available>#{available}</Available>" +
        "<Duration10>100</Duration10>" +
        "<Identifier>#{id}</Identifier>" +
        "</AppointmentSlot>"
      end
    end
  end  
end