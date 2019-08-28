require 'rubygems'
require 'bundler/setup'

require 'pg'
require 'active_record'
require './src/helpers/configurator'


namespace :db do

  desc 'Migrate the database'
  task :migrate do
    Helper::Configurator.connect_database
    ActiveRecord::MigrationContext.new('db/migrate').migrate
  end

  desc 'Create the database'
  task :create do
    connection_details = Helper::Configurator.database
    admin_connection   = connection_details.merge('database' => 'postgres',
                                                  'schema_search_path' => 'public')
    Helper::Configurator.connect_database(admin_connection)
    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

  desc 'Drop the database'
  task :drop do
    connection_details = Helper::Configurator.database
    admin_connection   = connection_details.merge('database' => 'postgres',
                                                  'schema_search_path' => 'public')
    Helper::Configurator.connect_database(admin_connection)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end

end