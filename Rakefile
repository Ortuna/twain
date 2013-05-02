require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'guard/jasmine/task'

PadrinoTasks.use(:database)
PadrinoTasks.use(:datamapper)
PadrinoTasks.init

task :default => :spec

task :default => :jasmine
begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end

Guard::JasmineTask.new do |task|
    task.options = '-e test -s jasmine_gem'
end