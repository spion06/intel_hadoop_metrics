require 'chefspec'
require 'chefspec/berkshelf'

current_dir = File.dirname(File.expand_path(__FILE__))

Dir[File.join(current_dir,"support/**/*.rb")].sort.each { |f| require f}

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do 
    # Redirect stderr and stdout
    $stderr = File.new(File.join(File.dirname(__FILE__), 'stderr.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'stdout.txt'), 'w')
  end
  config.after(:all) do 
    $stderr = original_stderr
    $stdout = original_stdout
  end
  config.log_level = :error

  # Specify the operating platform to mock Ohai data from (default: nil)
  config.platform = 'redhat'

  # Specify the operating version to mock Ohai data from (default: nil)
  config.version = '6.6'

end
