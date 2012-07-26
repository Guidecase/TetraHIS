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
    tetra.get_agenda_settings( praktijk_id )
    tetra.get_agenda_slots_with_settings( ['Consult', 'Spreekuur'] )
    tetra.find_agenda( agenda_id ).data => <Earlydoc::Tetra::Agenda>
    tetra.get_schema_blocks.data => [<Earlydoc::Tetra::SchemaBlock>,..]

Use the appointment methods to manage appointments for known patients, or unknown patients with search params:

    tetra.find_patient_appointments( patient_id )
    tetra.cancel_patient_appointment( appointment_id )
    tetra.make_appointment( agenda_id, patient_id, DateTime.now + 1.hour, DateTime.now + 90.minutes, 'any additional remarks' )
    tetra.make_appointment( agenda_id, {:last_name => surname, :email => email_addr, :birthday => bday}, DateTime.now + 1.hour, DateTime.now + 90.minutes, 'any additional remarks' )

Use the `find_patient` method with search params to locate patients:

    tetra.find_patient( :bsn => patient_bsn )
    tetra.find_patient( :last_name => surname )
    tetra.find_patient( :last_name => surname, :sex => 'M', :birthday => bday )

### Error Handling

Check the response for an API error, and inspect it for details about the error:

    response = tetra.get_agendas
    if response.error?
      p "#{response.error_code} #{response.error_message}"
    end

### Tetra Models

The various Tetra models represent the Tetra API's xml objects, and expose accessors on that data:

    Earlydoc:Tetra::Agenda.new => <Earlydoc::Tetra::Agenda @name=nil, @id=nil>

The models also expose a `to_xml` method that returns Tetra API-compatible XML:

    Earlydoc:Tetra::Slot.new.to_xml => "<AgendaOmschrijving><AgendaId></AgendaId><Naam></Naam></AgendaOmschrijving>"

The available Tetra models are:

+  `Earlydoc:Tetra::Agenda`
+  `Earlydoc:Tetra::SchemaBlock`
+  `Earlydoc:Tetra::SlotList`
+  `Earlydoc:Tetra::Slot`
+  `Earlydoc:Tetra::Patient`
+  `Earlydoc:Tetra::Appointment`