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
        @available = params['Available'] && params['Available'].to_s == 'true' ? true : false
        @doctor = params['Doctor']
      end

      def availabile=(val)
        @available = val && val.to_s == 'true' ? true : false
      end      

      def begin_time
        self.begin && self.begin.is_a?(String) ? Time.parse(self.begin) : self.begin
      end

      def end_time
        self.end ? Time.parse(self.end) : self.end
      end
      
      def time
        "#{begin_time.strftime('%A %d, %I:%M %p')}-#{end_time.strftime('%I:%M %p')}" if self.begin && self.end
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