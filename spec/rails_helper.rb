# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = Rails.root.join('spec/fixtures').to_s

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false
  config.before do
    stub_request(:any, /maps.googleapis.com/).to_return(status: 200, body: {}.to_json)
    stub_request(:any, /maps.googleapis.com\/maps\/api\/js/).to_return(status: 200, body: 'initMap();')
    response_body = [
      {
        place_id: 93812627,
        licence: "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        osm_type: "node",
        osm_id: 9132250573,
        boundingbox: ["33.901624", "33.921624", "133.179252", "133.199252"],
        lat: "33.911624",
        lon: "133.189252",
        display_name: "大町, Saijo, Ehime Prefecture, 793-0030, Japan",
        class: "place",
        type: "quarter",
        importance: 0.25,
        address: {
          quarter: "大町",
          city: "Saijo",
          province: "Ehime Prefecture",
          'ISO3166-2-lvl4': "JP-38",
          postcode: "793-0030",
          country: "Japan",
          country_code: "jp"
        }
      }
    ].to_json
    stub_request(:get, %r{nominatim.openstreetmap.org/search}).to_return(status: 200, body: response_body, headers: {})
  end
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :system

  config.after(:suite) do
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
  Webdrivers::Chromedriver.required_version = "114.0.5735.90"

  config.before(:all) do
    FileUtils.rm_rf(Dir[Rails.root.join("tmp/screenshots/*")], secure: true)
  end
  config.include FactoryBot::Syntax::Methods
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
  include ActiveSupport::Testing::FileFixtures
end
