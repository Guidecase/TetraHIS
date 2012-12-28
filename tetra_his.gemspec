$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name         = "tetra_his"
  s.version      = '0.1.1'
  s.platform     = Gem::Platform::RUBY  
  s.description  = "Tetra HIS"
  s.summary      = "Ruby API for the TetraHIS (GP management software) patient agenda module"
  s.author       = 'Earlydoc'
  s.email        = 'developer@earlydoc.com'
  s.homepage     = 'http://www.earlydoc.com'  
  s.require_path = 'lib'
  s.required_rubygems_version = ">= 1.8.x"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  
  s.add_dependency "activesupport"
  s.add_dependency "railties"
  s.add_dependency "libxml-ruby"
  s.add_dependency "libxml-to-hash"  
  s.add_dependency "httparty"  
end