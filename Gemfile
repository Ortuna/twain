source 'https://rubygems.org'

# gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'
gem 'active_model_serializers'
gem 'rake'

gem 'haml'
gem 'tilt', '~> 1.3.7'
gem 'dm-validations'
gem 'dm-types'
gem 'dm-core'
gem 'dm-gitfs-adapter', git: 'git@github.com:Ortuna/dm-gitfs-adapter.git'
gem 'dm-migrations'
gem 'dm-serializer'
gem 'omniauth'
gem 'omniauth-github'

group :production do 
  gem 'dm-postgres-adapter'
end

group :development, :test do
  gem 'pry'
  gem 'dm-sqlite-adapter'
  gem 'jasmine'
  gem 'guard-jasmine', :require => false  
end

group :test do
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
end

