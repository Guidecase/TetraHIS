Ruby TetraHIS
=============

API for the TetraHIS (GP management software) patient agenda module

    http://www.tetrahis.nl/

### Example Use

Require the gem from your project and initialize a new HIS instance with the Tetra service URI and your credentials:

    require 'tetra_his'
    tetra = Earlydoc::Tetra::HIS.new(SERVER_URI, YOUR_USERNAME, YOUR_PASSWORD)

The HIS instance exposes a number of RPC calls to the Tetra API. These calls always return a `Earlydoc::Tetra::Response` object. e.g.

    response = tetra.get_agendas

The response object exposes a data method which contains the models, if any, which were returned from the Tetra HIS service:

    tetra.get_agendas.data => [<Earlydoc::Tetra::Agenda>,..]
    tetra.get_agenda_slots.data => [<Earlydoc::Tetra::SlotList>,..]
    tetra.get_agenda_slots( DateTime.now + 3.days ).data => [<Earlydoc::Tetra::SlotList>,..]
    tetra.get_agenda_settings( practice_id )
    tetra.get_agenda_slots_with_settings( ['Consult', 'Spreekuur', 'Telefonisch consult', 'Koffie'] )
    tetra.find_agenda( agenda_id ).data => <Earlydoc::Tetra::Agenda>
    tetra.get_schema_blocks.data => [<Earlydoc::Tetra::SchemaBlock>,..]

Use the appointment methods to manage appointments for known patients, or unknown patients with search params:

    tetra.find_patient_appointments( patient_id ).data => [<Earlydoc::Tetra::Appointment>,..]
    tetra.cancel_patient_appointment( appointment_id )
    tetra.make_appointment( agenda_id, patient_id, DateTime.now + 1.hour, DateTime.now + 90.minutes, 'any additional remarks' ).data => <Earlydoc::Tetra::Appointment>
    tetra.make_appointment( agenda_id, {:last_name => surname, :email => email_addr, :birthday => bday}, DateTime.now + 1.hour, DateTime.now + 90.minutes, 'any additional remarks' ).data => <Earlydoc::Tetra::Appointment>

Use the `find_patient` method with search params to locate patients:

    tetra.find_patient( :bsn => patient_bsn ).data => <Earlydoc::Tetra::Patient>
    tetra.find_patient( :last_name => surname ).data => <Earlydoc::Tetra::Patient>
    tetra.find_patient( :last_name => surname, :sex => 'M', :birthday => bday ).data => <Earlydoc::Tetra::Patient>

**Slot Lists**

The `SlotList` is the main container for Tetra HIS agendas, and can be normalized by day using the `flat` method. An optional max_days parameter can be provided to limit the number of days in the list.

    my_slot_list.flat :max_days => 3

### Error Handling and Debugging

Check the response for an API error, and inspect it for details about the error:

    response = tetra.get_agendas
    if response.error?
      p "#{response.error_code} #{response.error_message}"
    end

Print out the request XML by passing a debug flag as the final arg to the Tetra client constructor:

   Earlydoc::Tetra::HIS.new 'example.com, 'un, 'pass', true

### Tetra Models

The various Tetra models represent the Tetra API's xml objects, and expose accessors on that data:

    Earlydoc:Tetra::Agenda.new => <Earlydoc::Tetra::Agenda @name=nil, @id=nil>

The models also expose a `to_xml` method that returns Tetra API-compatible XML:

    Earlydoc:Tetra::Slot.new.to_xml => "<AgendaOmschrijving><AgendaId></AgendaId><Naam></Naam></AgendaOmschrijving>"

The available Tetra models are:

+  `Earlydoc::Tetra::Agenda => <Earlydoc::Tetra::Agenda @name=nil, @id=nil>`
+  `Earlydoc::Tetra::SchemaBlock => <Earlydoc::Tetra::SchemaBlock @id=nil, @name=nil>`
+  `Earlydoc::Tetra::SlotList => <[<Earlydoc::Tetra::Slot>] @from=nil @to=nil @schema_block_id=nil @doctor=nil>`
+  `Earlydoc::Tetra::Slot => <Earlydoc::Tetra::Slot @id=nil, @agenda_id=nil, @begin=nil, @end=nil, @available=nil, @doctor=nil>`
+  `Earlydoc::Tetra::Patient => <Earlydoc::Tetra::Patient @id=nil @birthday=nil @sex=nil @last_name=nil, @full_name=nil>`
+  `Earlydoc::Tetra::Appointment => <Earlydoc::Tetra::Appointment>`

### Testing

Run the /test/integration_test_.rb file tests in order to test API methods against a live server. The necessary constants - `YOUR_SERVICE_IP`, `YOUR_USERNAME`, and `YOUR_PASSWORD` should be set manually in the rb file. By default, the integration tests are configured with `skip`; to run the integration tests, the skip line must be removed/commented out.

### Colophon

This Gem depends on the following core libraries:

+ httparty: https://github.com/jnunemaker/httparty
+ libxml-ruby: https://github.com/xml4r/libxml-ruby
+ libxml-to-hash: https://github.com/johannesthoma/libxml-to-hash

### License

The Ruby Tetra-HIS Gem is published under the New BSD license.