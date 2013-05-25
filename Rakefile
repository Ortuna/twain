require 'bundler/setup'
require 'padrino-core/cli/rake'


PadrinoTasks.use(:database)
PadrinoTasks.use(:datamapper)
PadrinoTasks.init

task :default => :tests

desc 'Run both javascript and rspec tests'
task :tests do
  Rake::Task["spec"].invoke
  Rake::Task["guard:jasmine"].invoke
end

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end

begin
  require 'guard/jasmine/task'
  Guard::JasmineTask.new { |t| t.options = '-e test -s jasmine_gem' }
rescue LoadError
  task :jasmine do
    abort "Guard::Jasmine not avail abortin"
  end
end
