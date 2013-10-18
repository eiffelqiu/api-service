require "rubygems"
require 'bundler'
require "bundler/setup"
require 'em-synchrony/activerecord'
require 'yaml'
require 'erb'
require 'grape'
require 'goliath'
require 'goliath/test_helper'
require 'rake'
require 'rspec'

require File.dirname(__FILE__) + '/app/api/msgs'
require File.dirname(__FILE__) + '/app/models/msg'

# 初始化时加载路径 app/api app/lib app/models
%w[api models lib].each do |folder|
   $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/app/#{folder}"))
end
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/spec"))

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec/core'
require 'rspec/core/rake_task'
 
RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.include Goliath::TestHelper, :example_group => {
    :file_path => /spec\//
  }  
end

desc 'Run all specs in spec folder'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.fail_on_error = false
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Default: run specs.'
task :default => :spec

desc 'Display routes'
RSpec::Core::RakeTask.new(:routes) do |spec|
  Goliath.env = :test
  ENV["RACK_ENV"] ||= 'test'
  ::Note::Msgs.routes.each do |route|
    p route
  end  
end

namespace :db do
  desc "loads database configuration in for other tasks to run"
  task :load_config do
    ActiveRecord::Base.configurations = db_conf
    
    # drop and create need to be performed with a connection to the 'postgres' (system) database
    ActiveRecord::Base.establish_connection db_conf["production"].merge('database' => 'postgres',
                                                                       'schema_search_path' => 'public')
  end
  
  desc "creates and migrates your database"
  task :setup => :load_config do
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end
  
  desc "migrate your database"
  task :migrate do
    ActiveRecord::Base.establish_connection db_conf["production"]

    ActiveRecord::Migrator.migrate(
      ActiveRecord::Migrator.migrations_paths, 
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end
  
  desc 'Drops the database'
  task :drop => :load_config do
    ActiveRecord::Base.connection.drop_database db_conf['production']['database']
  end
  
  desc 'Creates the database'
  task :create => :load_config do
    ActiveRecord::Base.connection.create_database db_conf['production']['database']
  end
  
end

def db_conf
  config = YAML.load(ERB.new(File.read('config/database.yml')).result)
end
