module ActsAsPluggable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def create_initializer_file
        create_file 'config/initializers/acts_as_pluggable.rb', '# Add initialization content here'
      end

      def add_plugins_to_gemfile
        inject_into_file 'Gemfile', after: "acts_as_pluggable\n" do
          <<-'RUBY'
			  		Dir.entries('plugins').select {|f| !File.directory? f}.each do |plugin|
					  gem plugin, path: 'plugins/'+plugin
					end
				RUBY
        end
    end
    end
  end
end
