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
  Mori::App.tap { |app|  }
end

Dir["#{SPEC_PATH}/helpers/**/*.rb"].each do |helper|
  require helper
end

def api_prefix
  Helper.api_prefix
end

def omniauth_login(opts = {})
  options = {
    'provider'     => 'github', 
    'access_token' => '123', 
    'uid'          => '123545',
    'info' => {
      'name'  => 'test',
      'image' => 'test' 
    }
  }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = options
  get '/auth/github'
  follow_redirect!
end
