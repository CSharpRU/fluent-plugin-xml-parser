# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'fluent-plugin-xml-parser'
  gem.homepage = 'https://github.com/CSharpRU/fluent-plugin-xml-parser'
  gem.license = 'BSD-3-Clause'
  gem.summary = 'Fluent parser for XML'
  gem.description = 'Fluent parser for XML that just converts XML to fluentd record fields'
  gem.email = 'c_sharp@mail.ru'
  gem.authors = ['Yaroslav Lukyanov']
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new

require 'rdoc/task'

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fluent-plugin-xml-parser #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Get spec rake tasks working in RSpec 2.0
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|

end
