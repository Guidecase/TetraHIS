require File.expand_path('../../test/test_helper', __FILE__)

class AgendaTest < Test::Unit::TestCase
  def test_initialize            
    params = {'AgendaId' => 1, 'Naam' => 'test'}
    agenda = Earlydoc::Tetra::Agenda.new(params)
    assert_equal params['AgendaId'], agenda.id, 'expected id initialized from constructor param'
    assert_equal params['Naam'], agenda.name, 'expected name initialized from constructor param'    
  end
  
  def test_to_xml
    params = {'AgendaId' => 1, 'Naam' => 'test'}
    agenda = Earlydoc::Tetra::Agenda.new(params)
    assert_valid_xml agenda
  end
end