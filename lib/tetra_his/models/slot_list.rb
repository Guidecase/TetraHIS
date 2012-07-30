module Earlydoc
  module Tetra  
    class SlotList < Array
      include Earlydoc::Tetra::TetraXmlDate
      
      attr_reader :from, :to, :schema_block_id, :doctor
  
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