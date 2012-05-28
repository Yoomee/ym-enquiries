module YmEnquiries
  module Generators    
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmEnquiries."

      def manifest
        try_migration_template "migrations/create_enquiries.rb", "db/migrate/create_enquiries"
        try_migration_template "migrations/create_enquiry_fields.rb", "db/migrate/create_enquiry_fields"
        
        if should_add_abilities?('YmEnquiry::Enquiry')
          add_ability(:open, "can :create, YmEnquiry::Enquiry")
        end
        
      end
      
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
      
      private
      def try_migration_template(source, destination)
        begin
          migration_template source, destination
        rescue Rails::Generators::Error => e
          puts e
        end
      end

      def should_add_abilities?(model_name)
        File.exists?("#{Rails.root}/app/models/ability.rb") && !File.open("#{Rails.root}/app/models/ability.rb").read.include?(model_name)
      end

      def add_ability(roles, abilities)
        [*roles].each do |role|
          tabbed_space = role==:open ? "\n    " : "\n      "
          ability_string = tabbed_space + [*abilities].join(tabbed_space)
          insert_into_file "app/models/ability.rb", ability_string, :after => "#{role} ability", :force => true
        end
      end
            
    end
  end
end
