# frozen_string_literal: true

require 'rubocop/rake_task'

RuboCop::RakeTask.new

desc 'Run RuboCop with auto-correction'
task :rubocop_fix do
  system('bundle exec rubocop --autocorrect')
end

desc 'Run RuboCop with aggressive auto-correction'
task :rubocop_fix_all do
  system('bundle exec rubocop -A')
end

desc 'Run all quality checks'
task quality: %i[rubocop spec]

desc 'Run tests'
task :spec do
  system('bundle exec rspec')
end

task default: :quality
