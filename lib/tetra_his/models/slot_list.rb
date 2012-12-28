module Earlydoc
  module Tetra  
    class SlotList < Array
      include Earlydoc::Tetra::TetraXmlDate
      
      attr_reader :from, :to, :schema_block_id, :doctor

      TEN_MIN_IN_SECONDS = 10*60
      HOUR_IN_SECONDS = 60*60
      
      RANGE_IN_HOURS = 5
      MORNING_START = 8
      MIDDAY_START = 13
      EVENING_START = 18

      class << self
        def block(day_part=:morning, ts=nil)
          start = case day_part
            when :morning
              MORNING_START
            when :midday
              MIDDAY_START
            when :evening
              EVENING_START
          end
          today = Time.parse "12:00 am", (ts || Time.now)
          list = Earlydoc::Tetra::SlotList.new 'BlockFrom' => today + (start * HOUR_IN_SECONDS), 
                                               'BlockEnd'  => today + (start * HOUR_IN_SECONDS) + (RANGE_IN_HOURS * HOUR_IN_SECONDS)

          RANGE_IN_HOURS.times do |h|
            6.times do |m|
              slot = Earlydoc::Tetra::Slot.new
              slot.begin = today + (start * HOUR_IN_SECONDS) + (h * HOUR_IN_SECONDS) + (m * TEN_MIN_IN_SECONDS)
              slot.end = slot.begin + TEN_MIN_IN_SECONDS
              list << slot
            end
          end
          list
        end
      end
  
      def initialize(params={})
        @from = params['BlockFrom']
        @to = params['BlockEnd']
        @doctor = params['Doctor']
        @schema_block_id = params['SchemaBlokId']
        
        if params['Items']
          slot_or_slots = params['Items']['AppointmentSlot']
          slots = slot_or_slots.is_a?(Array) ? slot_or_slots : [slot_or_slots]
          slots.each do |i|
            self << Earlydoc::Tetra::Slot.new(i)
          end
        end
      end
      
      def to_xml
      end
    end
  end  
end