module ForMash
  class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
   def copy_initializer
      template "for_mash.rb", "config/initializers/for_mash.rb"
    end
  end
end