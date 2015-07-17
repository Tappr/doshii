module Doshii
  class InstallGenerator < Rails::Generators::Base
    # source_root(File.expand_path(File.dirname(__FILE__))
    source_root File.expand_path('../templates', __FILE__)

    def copy_initializer_file
      copy_file 'doshii.rb', 'config/initializers/doshii.rb'
    end
  end
end
