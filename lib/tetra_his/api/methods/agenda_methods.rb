module Earlydoc
  module Tetra
    module AgendaMethods
      extend ActiveSupport::Concern
    
      def get_agenda_settings(praktijk_id)
        # API broken for agenda settings
        # rpc 'GetAgendaSettingsRequest', XML::Node.new('PraktijkId', praktijk_id.to_s)
      end
    
      def get_agenda_slots(day=nil)
        if day
          rpc 'GetAgendaSlotsSingleDayRequest', XML::Node.new('Datum', format_date(day)) do |response|
            unless response.hash['GetAgendaSlotsSingleDayResult']['AppointmentBlockList']['Items']['AppointmentSlotList'].nil?
              response.hash['GetAgendaSlotsSingleDayResult']['AppointmentBlockList']['Items']['AppointmentSlotList'].each do |params|
                response.data << Earlydoc::Tetra::SlotList.new( params )
              end
            end
          end
        else
          rpc 'GetAgendaSlotsRequest' do |response|
            unless response.hash['GetAgendaSlotsResult']['AppointmentBlockList']['Items']['AppointmentSlotList'].nil?
              response.hash['GetAgendaSlotsResult']['AppointmentBlockList']['Items']['AppointmentSlotList'].each do |params|
                response.data << Earlydoc::Tetra::SlotList.new( params )
              end                
            end
          end
        end
      end
    
      def get_agenda_slots_with_settings(types, minutes=30, max_days=1)
        block_types_node = XML::Node.new('BlockTypes', types.join(','))
        min_minutes_node = XML::Node.new('MinMinutesTillAppointment', minutes.to_s)
        max_days_node = XML::Node.new('MaxDays', max_days.to_s)
        
        rpc 'GetAgendaSlotsWithSettingsRequest', max_days_node, block_types_node, min_minutes_node do |response|
          unless response.hash['GetAgendaSlotsResult']['AppointmentBlockList']['Items']['AppointmentSlotList'].nil?            
            response.hash['GetAgendaSlotsResult']['AppointmentBlockList']['Items']['AppointmentSlotList'].each do |params|
              response.data << Earlydoc::Tetra::SlotList.new( params )
            end
          end
        end
      end
  
      def get_agendas
        rpc 'GetAgendasRequest' do |response|
          response.hash['GetAgendasResult']['Agendas']['AgendaOmschrijving'].each do |params|
            response.data << Earlydoc::Tetra::Agenda.new( params )
          end
        end     
      end
    
      def find_agenda(agenda_id)
        rpc 'GetAgendaRequest', XML::Node.new('AgendaId', agenda_id.to_s) do |response|
          response.data = Earlydoc::Tetra::Agenda.new response.hash['GetAgendaResult']
        end
      end    
    end      
  end    
end