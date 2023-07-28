require 'rails_helper'

RSpec.describe "Events" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let!(:user) { create(:user) }
  let!(:event) { create(:event, :with_image) }

  describe "#show" do
    context "when accessing the show page from the list" do
      it "displays event details" do
        visit events_path
        click_on event.name
        expect(page).to have_current_path event_path(event.id), ignore_query: true
        expect(page).to have_content event.name
        expect(page).to have_selector('img')
      end
    end

    context "when clicking the back link" do
      it "navigates back to the list" do
        visit events_path
        visit event_path(event.id)
        click_link "←戻る"
        expect(page).to have_current_path events_path, ignore_query: true
      end
    end
  end

  describe "#index" do
    it "displays events filtered by season" do
      create(:event, name: "Spring Event", season: "春")
      create(:event, name: "Summer Event", season: "夏")
      visit events_path
      page.find('li[data-season="summer"]').click
      expect(page).to have_content("Summer Event")
      expect(page).not_to have_content("Spring Event")
    end
  end
end
