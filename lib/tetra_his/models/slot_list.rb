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
          params['Items']['AppointmentSlot'].each do |i|
            self << Earlydoc::Tetra::Slot.new(i)
          end
        end
      end
      
      def to_xml
      end
    end
  end  
end