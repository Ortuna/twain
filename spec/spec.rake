begin
  require 'rspec/core/rake_task'

  spec_tasks = Dir['spec/*/'].map do |d| 
    next if d == 'spec/fixture/' || d == 'spec/helpers/'
    File.basename(d);
  end.compact!


  spec_tasks.each do |folder|
    RSpec::Core::RakeTask.new("spec:#{folder}") do |t|
      t.pattern = "./spec/#{folder}/**/*_spec.rb"
      t.rspec_opts = %w(--color -fp -b --order rand --require spec_helper)
      t.rspec_opts << %w(--seed 16618)
    end
  end

  desc "Run complete application spec suite"
  task 'spec' => spec_tasks.map { |f| "spec:#{f}" }
rescue LoadError
  puts "RSpec is not part of this bundle, skip specs."
end
