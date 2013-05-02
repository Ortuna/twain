# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

Padrino::Logger::Config[:development][:log_level]  = :devel
Padrino.before_load do
  Padrino.dependency_paths << "#{Padrino.root}/apps/**/*.rb"
end

Padrino.after_load do
  DataMapper.finalize
end

Padrino.load!
