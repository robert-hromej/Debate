require 'rubygems'
require 'spork'

if RUBY_VERSION == "1.9.2"
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_group "Models", "app/models"
    add_group "Controllers", "app/controllers"
    add_filter "/log/"
    add_filter "/vendor"
    add_filter "/lib/taskapp/controllerss"
    add_filter "/config"
  end
end

if Spork.using_spork?
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

Spork.prefork do

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'


  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


  RSpec.configure do |config|
    config.mock_with :rspec
    config.include Factory::Syntax::Methods
    config.use_transactional_fixtures = true
    #config.filter_run_excluding :slow => true
    #config.filter_run :focus => true


    def test_sign_in(user)
      controller.sign_in(user)
    end

    def test_sign_out
      controller.sign_out
    end

    def clean_db
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start #cleaning database
      DatabaseCleaner.clean
    end


    def freeze_time(time = Time.new)
      Timecop.return
      @time = Timecop.freeze(time)
    end
    # reload models
    ActiveSupport::Dependencies.clear
    ActiveRecord::Base.instantiate_observers
  end
end

Spork.each_run do
  Debate::Application.reload_routes!
  FactoryGirl.reload
end
