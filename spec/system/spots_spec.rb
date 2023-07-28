require 'rails_helper'

RSpec.describe "Spots" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe "#show", js: true do
    let!(:user) { create(:user) }
    let!(:spot) { create(:spot, :with_icon) }

    context "when accessing the show page from the list" do
      it "displays spot contents" do
        visit spots_path
        expect(page).to have_content spot.name
        expect(page).to have_selector('.img', count: Spot.count)

        click_on spot.name
        expect(page).to have_current_path spot_path(spot.id), ignore_query: true
        expect(page).to have_content spot.name
        expect(page).to have_content spot.address
      end

      it "displays spot map" do
        visit spots_path
        click_on spot.name

        expect(page).to have_selector('.gm-style')
        expect(page).to have_selector('#content')
        expect(page).to have_selector('h3', text: spot.name)
        expect(page).to have_selector('p', text: spot.address)
      end 
    end

    context "when clicking the back link" do
      it "navigates back to the list" do
        visit spots_path
        visit spot_path(spot.id)
        click_link "←戻る"
        expect(page).to have_current_path spots_path, ignore_query: true
      end
    end
  end

  describe "#index", js: true do
    let!(:imabari) { create(:spot, :with_icon, name: "Spot 1", category: "観光地", city: "1", address: "Imabari") }
    let!(:niihama) { create(:spot, :with_icon, name: "Spot 2", category: "レジャー", city: "1", address: "Niihama") }
    let!(:uchiko) { create(:spot, :with_icon, name: "Spot 3", category: "レジャー", city: "3", address: "Uchiko") }

    before do
      visit spots_path
    end
  
    it "displays spot list" do
      expect(page).to have_content imabari.name
      expect(page).to have_content niihama.name
      expect(page).to have_content uchiko.name
      expect(page).to have_selector('.img', count: Spot.count)
    end

    it "displays spot list filters by area" do
      select "東予", from: "area"
      click_button "検索"
      expect(page).to have_content imabari.name
      expect(page).to have_content niihama.name
      expect(page).not_to have_content uchiko.name
    end

    it "displays spot list filters by area and category" do
      select "東予", from: "area"
      select "観光地", from: "category"
      click_button "検索"
      expect(page).to have_content imabari.name
      expect(page).not_to have_content niihama.name
    end

    it "displays spot list filters by area and category and address" do
      select "東予", from: "area"
      select "観光地", from: "category"
      fill_in 'keyword', with: uchiko.address
      click_button "検索"
      expect(page).not_to have_content imabari.name
      expect(page).not_to have_content niihama.name
      expect(page).not_to have_content uchiko.name
    end
  end
end
