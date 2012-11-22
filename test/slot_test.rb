require File.expand_path('../../test/test_helper', __FILE__)

class SlotTest < Test::Unit::TestCase
  
  def test_initialize
    params = {'Identifier' => 1, 'AgendaID' => 1, 'DateTime' => DateTime.now, 'TimeTill' => DateTime.now + (60 * 60), 'Available' => 'true', 'Doctor' => 'GP'}
    slot = Earlydoc::Tetra::Slot.new(params)
    
    assert_equal params['Identifier'], slot.id, 'expected id initialized from constructor param'
    assert_equal params['AgendaID'], slot.agenda_id, 'expected agenda id initialized from constructor param'    
    assert_equal params['DateTime'], slot.begin, 'expected begin time initialized from constructor param'    
    assert_equal params['TimeTill'], slot.end, 'expected end time initialized from constructor param'        
    assert_equal params['Doctor'], slot.doctor, 'expected doctor initialized from constructor param'
  end

  def test_availability
    slot = Earlydoc::Tetra::Slot.new 'Available' => 'true'
    assert_equal true, slot.available, "expected true availability initialized from 'true'"
    slot = Earlydoc::Tetra::Slot.new 'Available' => 'false'
    assert_equal false, slot.available, "expected true availability initialized from 'false'"
    slot = Earlydoc::Tetra::Slot.new 'Available' => true
    assert_equal true, slot.available, "expected true availability initialized from true bool"
    slot = Earlydoc::Tetra::Slot.new 'Available' => false
    assert_equal false, slot.available, "expected true availability initialized from false bool"

    slot.availabile = 'true'
    assert_equal true, slot.available, "expected true availability set from 'true'"
    slot.availabile = 'false'
    assert_equal false, slot.available, "expected false availability set from 'false'"
    slot.availabile = true
    assert_equal true, slot.available, "expected true availability set from true"
    slot.availabile = false
    assert_equal false, slot.available, "expected false availability set from false"
  end
  
  def test_to_xml
    params = {'Identifier' => 1, 'AgendaID' => 1, 'DateTime' => DateTime.now, 'TimeTill' => DateTime.now + (60 * 60), 'Available' => true, 'Doctor' => 'GP'}
    slot = Earlydoc::Tetra::Slot.new(params)
    assert_valid_xml slot
  end  
  
  def test_time
    slot = Earlydoc::Tetra::Slot.new
    assert_nil slot.time, 'expected no time without begin and end times'
    slot.begin = DateTime.now.to_s
    assert_nil slot.time, 'expected no time without end time'
    slot.end = (DateTime.now + 100000).to_s
    assert_not_nil slot.time, 'expected display time from begin and end'
  end

  def test_begin_time
    slot = Earlydoc::Tetra::Slot.new
    slot.begin = Time.now.to_s
    assert slot.begin_time.is_a?(Time), 'expected time object from time string'
    slot.begin = Time.now
    assert slot.begin_time.is_a?(Time), 'expected time object from time'
  end
end