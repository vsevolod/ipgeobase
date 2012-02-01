require 'rails/generators'
require 'rails/generators/migration'

module Ipgeobase
  module Generators
    class ModelsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Generates migration for Ipgeobase models"

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates', 'models/'))
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_models
        [:ipgeobase_ips, :ipgeobase_region].each do |filename|
          template "#{generator_dir}/ipgeobase/#{filename}.rb",
          File.join("app/models/ipgeobase/#{filename}.rb")
        end
      end

      def create_migration
        if ["active_record"].include?(orm)
          migration_template "#{generator_dir}/migration.rb", File.join('db/migrate', "create_tables_for_ipgeobase.rb")
        end
      end

      protected

      def generator_dir
        @generator_dir ||= orm
      end

      def uploaders_dir
        @uploaders_dir ||= ['base', 'carrierwave'].join('/')
      end

      def orm
        "active_record"
      end
    end
  end
end

