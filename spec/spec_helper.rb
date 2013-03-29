PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

SPEC_PATH    = File.expand_path(File.dirname(__FILE__))
FIXTURE_PATH = "#{SPEC_PATH}/fixtures/**/*.rb"

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Twain::App.tap { |app|  }
end
