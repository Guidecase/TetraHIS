require 'test/unit'
require File.join(File.dirname(__FILE__), '..', 'lib', 'tetra_his.rb')

def assert_api_success(response)
  assert_equal false, response.error?, "expected successful api response but was: #{response.error_code} #{response.error_message}"
end

def assert_valid_xml(model)
  assert_nothing_raised do
    XML::Parser.document( XML::Document.string(model.to_xml) )
  end  
end