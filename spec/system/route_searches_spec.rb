require 'rails_helper'

RSpec.describe "RouteSearches", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe "#index" do
    it "click button and view the route" do
      visit routes_path
      click_on('海と自然を満喫ルート')
      expect(page).to have_selector('.route', count: 4)
    end
  end
end
