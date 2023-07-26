require 'rails_helper'

RSpec.describe "Spots", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:user) { FactoryBot.create(:user) }
  let!(:spot) { FactoryBot.create(:spot, :with_icon) }

  describe "#create" do
    it "user creates a new spot" do
      sign_in user
      visit admin_root_path
      click_link "Spots"
      visit "/admin/spots/new"
      fill_in "Address", with: "Ehime"
      fill_in "Name", with: "Park"
      fill_in "City", with: "1"
      fill_in "Category", with: "レジャー"
      click_button "登録する"
      expect(page).to have_content "Spotを作成しました。"
    end
  end

  describe "#show", js: true do
    it "move from list to detail" do
      visit spots_path
      expect(page).to have_content spot.name
      expect(page).to have_selector('.img', count: Spot.count)

      click_on spot.name
      expect(current_path).to eq spot_path(spot.id)
      expect(page).to have_content spot.name
      expect(page).to have_content spot.address

      expect(page).to have_selector('.gm-style')
      expect(page).to have_selector('#content')
      expect(page).to have_selector('h3', text:'伊予西条駅')
      expect(page).to have_selector('p', text:'愛媛県西条市大町')
    
      click_link "←戻る"
      expect(current_path).to eq spots_path
    end
  end
end
