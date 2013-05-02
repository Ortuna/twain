PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

SPEC_PATH    = File.expand_path(File.dirname(__FILE__))
FIXTURE_PATH = "#{SPEC_PATH}/fixtures/**/*.rb"

#only the :default repo, not gitfs
DataMapper.repository.auto_migrate!

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  API::App.tap { |app|  }
end

Dir["#{SPEC_PATH}/helpers/**/*.rb"].each do |helper|
  require helper
end