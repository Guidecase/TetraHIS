module Earlydoc
  module Tetra
    module PatientMethods
      extend ActiveSupport::Concern
    
      def find_patient(options)
        if options.has_key?(:bsn)
          find_patient_by_bsn options[:bsn]
          
        elsif options.has_key?(:last_name) || options.has_key?(:birthday)
          find_patient_by_search options[:last_name], options[:birthday], options[:sex]
        end
      end
      
      def find_patient_by_bsn(bsn)
        rpc 'FindPatientBSNRequest', XML::Node.new('BSN', bsn) do |response|
          response.data = Earlydoc::Tetra::Patient.new response.hash['FindPatientBSNResult']
        end
      end
      
      def find_patient_by_search(last_name, birthday, sex)
        sex_node = XML::Node.new('Sex', sex)          
        name_node = XML::Node.new('Lastname', last_name)
        birthday_node = XML::Node.new('BirthDay', format_date(birthday))
        
        rpc 'FindPatientRequest', name_node, birthday_node, sex_node do |response|
          response.data = Earlydoc::Tetra::Patient.new response.hash['FindPatientResult']
        end
      end
    end
  end    
end