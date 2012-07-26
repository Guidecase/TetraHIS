require File.expand_path('../../test/test_helper', __FILE__)

class SlotTest < Test::Unit::TestCase
  
  def test_initialize
    params = {'Identifier' => 1, 'AgendaID' => 1, 'DateTime' => DateTime.now, 'TimeTill' => DateTime.now + (60 * 60), 'Available' => true, 'Doctor' => 'GP'}
    slot = Earlydoc::Tetra::Slot.new(params)
    
    assert_equal params['Identifier'], slot.id, 'expected id initialized from constructor param'
    assert_equal params['AgendaID'], slot.agenda_id, 'expected agenda id initialized from constructor param'    
    assert_equal params['DateTime'], slot.begin, 'expected begin time initialized from constructor param'    
    assert_equal params['TimeTill'], slot.end, 'expected end time initialized from constructor param'    
    assert_equal params['Available'], slot.available, 'expected availability initialized from constructor param'    
    assert_equal params['Doctor'], slot.doctor, 'expected doctor initialized from constructor param'
  end
  
  def test_to_xml
    params = {'Identifier' => 1, 'AgendaID' => 1, 'DateTime' => DateTime.now, 'TimeTill' => DateTime.now + (60 * 60), 'Available' => true, 'Doctor' => 'GP'}
    slot = Earlydoc::Tetra::Slot.new(params)
    assert_valid_xml slot
  end  
end