require 'active_support'
require 'httparty'
require 'xml'
require 'cgi'
require 'libxml_to_hash'

require 'tetra_his/serialization/tetra_xml_date'

require 'tetra_his/models/schema_block'
require 'tetra_his/models/agenda'
require 'tetra_his/models/slot_list'
require 'tetra_his/models/slot'
require 'tetra_his/models/patient'
require 'tetra_his/models/appointment'

require 'tetra_his/api/methods/agenda_methods'
require 'tetra_his/api/methods/appointment_methods'
require 'tetra_his/api/methods/patient_methods'

require 'tetra_his/api/his'
require 'tetra_his/api/response'

