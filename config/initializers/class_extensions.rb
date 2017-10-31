Dir[File.join(Rails.root, "lib", "class_extensions", "*.rb")].each {|l| require l }
