require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start!

current_dir = File.dirname(File.expand_path(__FILE__))

Dir[File.join(current_dir,"support/**/*.rb")].sort.each { |f| require f}

