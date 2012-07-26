module Earlydoc
  module Tetra
    module TetraXmlDate
      extend ActiveSupport::Concern
      
      def format_date(datetime, format="%Y-%m-%dT00:00:00")
        datetime ? datetime.strftime(format) : nil
      end      
    end      
  end
end