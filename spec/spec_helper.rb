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
  Twain::App.tap { |app|  }
end


module Helper
  class << self  
    def create_user(username, password)
      User.new.tap do |user|
        user.username = username
        user.password = password
        user.save
      end
    end

    def clean_users
      User.all.destroy
    end

    def setup_api(git_path, username = 'apiuser', password = 'password')
      create_user(username, password)
      Twain::API.new(git: git_path,
                     prefix: "#{Padrino.root}/tmp",
                     username: username,
                     password: password)
    end

    def parse_json(json)
      MultiJson.load(json)
    end
  end
end