require File.expand_path('../../test/test_helper', __FILE__)

class TetraXmlDateTest < Test::Unit::TestCase
  class MockObject
    include Earlydoc::Tetra::TetraXmlDate
  end
  
  def test_format_date
    obj = MockObject.new
    date = DateTime.now
    assert_equal date.strftime("%Y-%m-%dT00:00:00"), obj.format_date(date), 'expected api format from date'
    assert_nil obj.format_date(nil), 'expected nil from nil date'
    assert_equal 'test', obj.format_date(date, 'test'), 'expected api format override'    
  end
end