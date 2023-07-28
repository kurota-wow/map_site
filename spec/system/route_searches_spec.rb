require 'rails_helper'

RSpec.describe "RouteSearches" do
  describe "#index" do
    before do
      driven_by(:selenium_chrome_headless)
      visit routes_path
    end

    it "displays the page with correct content", js: true do
      expect(page).to have_selector('.selection a', count: 4)
      expect(page).to have_selector('.route', count: 4)
      expect(page).to have_selector('.route-image', count: 4)
      expect(page).to have_selector('.route-section .section', count: 12)
      click_link('愛媛をぐるっとよくばりルート')
      sleep 1
      route_section = find('.back').find('a#link2', visible: :all)
      expect(page.evaluate_script("$(window).scrollTop()")).to eq(route_section.native.location.y)
    end

    it "has the correct layout and design" do
      expect(page).to have_css('.back')
      expect(page).to have_css('.selection-screen')
      expect(page).to have_css('.route-map')
      expect(page).to have_css('.gotop')
    end
  end
end
