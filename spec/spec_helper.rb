PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.expand_path(File.dirname(__FILE__) + '/spec_extender')

SPEC_PATH    = File.expand_path(File.dirname(__FILE__))
FIXTURE_PATH = "#{SPEC_PATH}/fixtures/**/*.rb"


#only the :default repo, not gitfs
DataMapper.repository.auto_migrate!

Dir["#{SPEC_PATH}/helpers/**/*.rb"].each do |helper|
  require helper
end

 
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include SpecExtender
end