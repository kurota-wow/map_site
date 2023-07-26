# spec/support/selenium_driver_with_webmock.rb
require 'capybara/rspec'
require 'webmock/rspec'

Capybara.register_driver :selenium_with_webmock do |app|
  # Seleniumドライバーを設定
  driver = Capybara::Selenium::Driver.new(app, browser: :chrome)

  # Chromeのオプションを指定
  options = driver.browser.options
  options.add_argument('--headless') # ヘッドレスモードで実行（オプション）
  options.add_argument('--disable-gpu') # ヘッドレスモードの場合、GPUを無効にする（オプション）

  driver
end

Capybara.default_driver = :selenium_with_webmock
WebMock.disable_net_connect!(allow_localhost: true)
