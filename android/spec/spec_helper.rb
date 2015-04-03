require 'rspec'
require 'appium_lib'
require 'sauce_whisk'
require 'pry'
require_relative '../pages/home'
require_relative '../pages/inner_screen'

def using_sauce?
  user = ENV['SAUCE_USERNAME']
  key = ENV['SAUCE_ACCESS_KEY']
  user && !user.empty? && key && !key.empty?
end

def upload_app
  storage = SauceWhisk::Storage.new
  app = @caps[:caps][:app]
  storage.upload app
  @caps[:caps][:app] = "sauce-storage:#{File.basename(app)}"
end

def setup_driver
  return if $driver
  appium_txt = File.join(Dir.pwd, 'appium.txt')
  @caps = Appium.load_appium_txt file: appium_txt
  if using_sauce?
    upload_app
    @caps[:caps].delete :avd
  end
  Appium::Driver.new(@caps)
end

def promote_methods
  Appium.promote_singleton_appium_methods Pages
  Appium.promote_appium_methods RSpec::Core::ExampleGroup
end

setup_driver
promote_methods

RSpec.configure do |config|

  config.before(:each) do |example|
    $driver.caps[:name] = example.metadata[:full_description] if using_sauce?
    $driver.start_driver
  end

  config.after(:each) do |example|
    if using_sauce?
      SauceWhisk::Jobs.change_status($driver.driver.session_id, example.exception.nil?)
    end
    driver_quit
  end
end
