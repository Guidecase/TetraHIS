require File.expand_path('../../test/test_helper', __FILE__)

class HISTest < Test::Unit::TestCase
  class MockHttpResponse
    attr_accessor :body, :headers, :request, :response
    
    def initialize(xml); @body = xml; end
    def to_s; body; end
  end
  
  def setup
    @simple_xml = "<APIMessageResponse></APIMessageResponse>"    
    @error_xml = "<APIMessageResponseError><ErrorCode>999</ErrorCode><ErrorString>Test Error</ErrorString></APIMessageResponseError>"
  end
  
  def mock_response(xml)
    MockHttpResponse.new(xml)
  end

  def test_initialize
    mock = mock_response(@simple_xml)
    response = Earlydoc::Tetra::Response.new mock
    assert_equal mock, response.raw, 'expected raw data initialized from constructor param'
  end
  
  def test_error
    response = Earlydoc::Tetra::Response.new mock_response(@simple_xml)
    assert_equal false, response.error?, 'expected no error without error code'
    
    response = Earlydoc::Tetra::Response.new mock_response(@error_xml)
    assert_equal true, response.error?, 'expected error when error code present'
  end

  def test_error_code
    response = Earlydoc::Tetra::Response.new mock_response(@error_xml)
    assert_equal '999', response.error_code, 'expected parsed code text when error code present'
  end
  
  def test_error_message
    response = Earlydoc::Tetra::Response.new mock_response(@error_xml)
    assert_equal 'Test Error', response.error_message, 'expected parsed error text when error string present'
  end
end