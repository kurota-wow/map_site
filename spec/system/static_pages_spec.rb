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
      execute_script('window.scrollBy(0,50)')
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

    context "with ranking" do
      let!(:top_spots) { create_list(:spot, 3) }
      let!(:other_spot) { create(:spot, name: "spot") }
      let!(:customer) { create(:customer) }
      let!(:other_customer) { create(:customer, email: "other@example.com") }

      before do
        top_spots.each do |spot|
          create(:bookmark, spot:, customer:)
        end
        create(:bookmark, spot: other_spot, customer:)
        visit root_path
        execute_script('window.scrollBy(0,10000)')
      end

      it "displays ranking section" do
        expect(page).to have_selector('.ranking')
      end

      it "displays top spots in ranking" do
        top_spots.each do |spot|
          expect(page).to have_text(spot.name)
          expect(page).to have_link("", href: spot_path(spot))
        end
      end

      it "displays update ranking" do
        expect(page).not_to have_text(other_spot.name)
        create(:bookmark, spot: other_spot, customer: other_customer)
        visit root_path
        execute_script('window.scrollBy(0,10000)')
        expect(page).to have_text(other_spot.name)
      end
    end
  end

  describe "#help" do
    it "displays help page correctly" do
      visit help_path
      expect(page).to have_selector('.help-contents')
    end
  end
end
