require File.expand_path('../../test/test_helper', __FILE__)

class HISTest < Test::Unit::TestCase
  
  def test_initialize
    @tetra = Earlydoc::Tetra::HIS.new('uri', 'un', 'pw')
    assert_equal 'un', @tetra.auth[:username], 'expected auth username initialized from constructor param'
    assert_equal 'pw', @tetra.auth[:password], 'expected auth password initialized from constructor param'    
    assert_equal 'http://uri', Earlydoc::Tetra::HIS.base_uri, 'expected httparty base uri initialized from constructor param'
  end
  
  def test_request_xml
    @tetra = Earlydoc::Tetra::HIS.new('uri', 'un', 'pw')
    assert @tetra.send(:request_xml, 'TestRequest'), 'expected xml string'
  end
  
  def test_encoded_xml
    @tetra = Earlydoc::Tetra::HIS.new('uri', 'un', 'pw')
    doc = XML::Document.new
    assert @tetra.send(:encoded_xml, doc).is_a?(String), 'expected xml string'
  end
end