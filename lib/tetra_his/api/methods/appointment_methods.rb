module Earlydoc
  module Tetra
    module AppointmentMethods
      extend ActiveSupport::Concern
    
      def make_appointment(agenda_id, patient_id_or_options, from, to, remarks=nil)
        agenda_node = XML::Node.new('AgendaId', agenda_id.to_s)
        remarks_node = XML::Node.new('Remarks', remarks)
        from_node = XML::Node.new('TimeFrom', format_date(from, "%Y-%m-%dT%H:%M:00"))
        to_node = XML::Node.new('TimeTill', format_date(to, "%Y-%m-%dT%H:%M:00"))
        
        if patient_id_or_options.is_a? Hash
          sex_node = XML::Node.new('Sex', patient_id_or_options[:sex])          
          name_node = XML::Node.new('Lastname', patient_id_or_options[:last_name])
          email_node = XML::Node.new('Email', patient_id_or_options[:email])
          rpc 'MakeAppointmentUnknownPatientRequest', agenda_node, name_node, sex_node, email_node, from_node, to_node, remarks_node do |response|
          end
        else
          patient_node = XML::Node.new('PatientId', patient_id_or_options.to_s)
          rpc 'MakeAppointmentRequest', agenda_node, patient_node, from_node, to_node, remarks_node do |response|
            response.data = Earlydoc::Tetra::Appointment.new response.hash['MakeAppointmentResult']
          end
        end
      end
    
      def find_patient_appointments(patient_id)
        rpc 'GetPatientAfsprakenRequest', XML::Node.new('PatientId', patient_id.to_s) do |response|
          response.hash['GetPatientAfsprakenResult']['Afspraken']['PatientAfspraak'].each do |params|
            response.data << Earlydoc::Tetra::Appointment.new( params )
          end
        end
      end   
    
      def cancel_patient_appointment(appointment_id)
        rpc 'DelPatientAfspraakRequest', XML::Node.new('Id', appointment_id.to_s) do
        end
      end     
    
      def get_schema_blocks
        rpc 'GetSchemaBlokkenRequest' do |response|
          response.hash['GetSchemaBlokkenResult']['SchemaBlokken']['SchemaBlok'].each do |params|
            response.data << Earlydoc::Tetra::SchemaBlock.new( params )
          end
        end
      end
    end
  end    
end