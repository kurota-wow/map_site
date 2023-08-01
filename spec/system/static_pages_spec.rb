require 'rails_helper'

RSpec.describe "StaticPages" do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size:[1300, 1100]
  end

  describe "#home", js: true do
    before do
      visit root_path
      spot1 = create(:spot, :with_icon)
    end

    it "show header" do
      expect(page).to have_selector('header')
    end

    it "toggle map with button" do
      expect(page).to have_selector('#main-map')
      expect(page).to have_selector('#image1')
      expect(page).to have_selector('#btn2')
      find_by_id('btn1').click
      find_by_id('btn2').click
      expect(page).to have_selector('#image2')
      expect(page).not_to have_selector('#image1')
    end

    it "click the icon move to details screen" do
      find_by_id('dougo').click
      expect(page).to have_current_path "/spots/1"
    end

    it "show text wirh scroll" do
      visit root_path
      expect(page).not_to have_text("ピックアップ")
      execute_script('window.scrollBy(0,10000)')
      expect(page).to have_text("ピックアップ")
    end

    it "show carousel" do
      visit current_path
      execute_script('window.scrollBy(0,10000)')
      expect(page).to have_selector('.slide img[alt="青島"]')
      expect(page).to have_selector('.next')
      find('.next').click
      expect(page).to have_link '石鎚'
      expect(page).to have_link('下灘駅', wait: 10)
    end

    it "show footer" do
      expect(page).to have_selector('.wave')
      expect(page).to have_selector('footer')
    end

    it "click and go to top" do
      visit root_path
      execute_script('window.scrollBy(0,2000)')
      page.find('.gotop').click
      sleep 5
      expect(page.evaluate_script("$(window).scrollTop()")).to eq(0)
    end
  end

  describe "#about" do
    it "displays site map links in header correctly" do
      visit about_path
      expect(page).to have_link "ぐるぐるマップから探す", href: root_path
      expect(page).to have_link "スポットリストから探す", href: spots_path
      expect(page).to have_link "イベントリストから探す", href: events_path
      expect(page).to have_link "おすすめルートから探す", href: routes_path
    end

    it "displays site map links in footer correctly" do
      visit about_path
      expect(page).to have_link "お問い合わせ", href: new_contact_path
      expect(page).to have_link "よくある質問", href: help_path
    end
  end

  describe "#help" do
    it "displays help page correctly" do
      visit help_path
      expect(page).to have_selector('.help-contents')
    end
  end
end
