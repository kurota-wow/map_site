require 'rails_helper'

RSpec.describe "Footer" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe "Footer links" do
    it "displays the correct links in the navigation menu" do
      visit root_path
      expect(page).to have_link('サイトマップ', href: about_path)
      expect(page).to have_link('お問い合わせ', href: new_contact_path)
      expect(page).to have_link('よくある質問', href: help_path)
    end

    it "clicking on the links navigates to the correct pages" do
      visit root_path
      within ".footer" do
        click_link('サイトマップ')
        expect(page).to have_current_path(about_path)

        click_link('お問い合わせ')
        expect(page).to have_current_path(new_contact_path)

        click_link('よくある質問')
        expect(page).to have_current_path(help_path)
      end
    end
  end

  describe "Social media icons" do
    it "displays social media icons with correct links" do
      visit root_path
      expect(page).to have_link 'Twitter'
      expect(page).to have_link 'Facebook'
      expect(page).to have_link 'Pinterest'
    end
  end

  describe "Copyright notice" do
    it "displays the correct copyright notice" do
      visit root_path
      expect(page).to have_content("©︎2023 ぐるぐるマップえひめ")
    end
  end
end
