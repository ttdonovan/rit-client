require 'rake'
require 'bundler'
begin
  Bundler.setup(:runtime, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = "rit-client"
  gem.summary     = %Q{A gem that used to consume Rit content (currently within a Rails application).}
  gem.description = %Q{A client that is used to consume Rit content (currently within a Rails applicaiton).}
  gem.email       = "ttdonovan@gmail.com"
  gem.homepage    = "http://github.com/ttdonovan/rit-client"
  gem.authors     = ["Tanner Donovan"]
  # dependencies defined in Gemfile
  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end

# TODO: uncomment when ready to release and manage the wild
# Jeweler::GemcutterTasks.new

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rit_client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end