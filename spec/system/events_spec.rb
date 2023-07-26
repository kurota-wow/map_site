require 'rails_helper'

RSpec.describe "Events", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end
  let(:user) { FactoryBot.create(:user) }
  let!(:event) { FactoryBot.create(:event, :with_image) }

  describe "#create" do
    it "user creates a new event" do
      sign_in user
      visit admin_root_path
      click_link "Events"
      visit "/admin/events/new"
      fill_in "Season", with: "春"
      fill_in "Name", with: "お祭り"
      click_button "登録する"
      expect(page).to have_content "Eventを作成しました。"
    end
  end

  describe "#show" do
    it "move from list to detail" do
      visit events_path
      find("#summer").click
      expect(page).to have_content event.name

      click_on event.name
      expect(current_path).to eq event_path(event.id)
      expect(page).to have_content event.name
      expect(page).to have_selector('img')

      click_link "←戻る"
      expect(current_path).to eq events_path
    end
  end

end
