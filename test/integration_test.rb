require File.expand_path('../../test/test_helper', __FILE__)

class IntegrationTest < Test::Unit::TestCase
  YOUR_SERVICE_IP = '127.0.0.1:3000'
  YOUR_USERNAME   = nil
  YOUR_PASSWORD   = nil
  
  def setup
    #### comment the following line to run integration tests ####
    skip 'Skipping integration test with live Tetra HIS service'
  
    @tetra = Earlydoc::Tetra::HIS.new(YOUR_SERVICE_IP, YOUR_USERNAME, YOUR_PASSWORD)
  end

  def test_get_agendas
    response = @tetra.get_agendas
    assert_api_success response
  end
  
  def test_find_agenda
    response = @tetra.find_agenda 10077
    assert_api_success response
  end
  
  def test_get_agenda_slots
    response = @tetra.get_agenda_slots
    assert_api_success response
  end
  
  def test_get_agenda_slots_with_day
    response = @tetra.get_agenda_slots DateTime.now + (7*24*60*60)
    assert_api_success response
  end  
  
  def test_get_agenda_slots_with_settings
    response = @tetra.get_agenda_slots_with_settings ['Consult', 'Spreekuur']
    assert_api_success response
  end
  
  def test_find_patient_by_bsn
    response = @tetra.find_patient :bsn => '123456789'
    assert_api_success response
  end
  
  def test_find_patient_by_search
    response = @tetra.find_patient :last_name => 'Jansen', :birthday => DateTime.new('1972-03-08'), :sex => 'M'
    assert_api_success response
  end
  
  def test_get_schema_blocks
    response = @tetra.get_schema_blocks
    assert_api_success response
  end
end