require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size:[1300, 1100]
  end

  describe "#home", js: true do
    before do
      visit root_path
      spot1 = FactoryBot.create(:spot, :with_icon)
    end

    it "show header" do
      expect(page).to have_link 'ぐるぐるマップ愛媛', href: '/'
      expect(page).to have_link 'ぐるぐるマップ', href: '/'
      expect(page).to have_link 'スポット', href: '/spots'
      expect(page).to have_link 'イベント', href: '/events'
      expect(page).to have_link 'おすすめルート', href: '/routes'
    end

    it "toggle map with button" do
      expect(page).to have_selector('#map')
      expect(page).to have_selector('#image1')
      expect(page).to have_selector('#btn2')
      find('#btn1').click
      find('#btn2').click
      expect(page).to have_selector('#image2')
      expect(page).not_to have_selector('#image1')
    end

    it "click the icon move to details screen" do
      find('#dougo').click
      expect(current_path).to eq "/spots/1"
    end

    it "show text wirh scroll" do
      expect(page).not_to have_text("ぐるぐるマップでさがそう")
      execute_script('window.scrollBy(0,10000)')
      expect(page).to have_text("ぐるぐるマップでさがそう")
    end

    it "show carousel" do
      visit current_path
      execute_script('window.scrollBy(0,10000)')
      expect(page).to have_link '青島'
      expect(page).to have_selector('.next')
      find('.next').click
      expect(page).to have_link '石鎚'
      sleep 8
      expect(page).to have_link '下灘駅'
    end

    it "show link on footer" do
      expect(page).to have_selector('.wave')
      expect(page).to have_link 'サイトマップ', href: '/about'
      expect(page).to have_link 'お問い合わせ', href: '/contact/new'
      expect(page).to have_link 'よくある質問', href: '/help'
    end

    it "show sns_icon on footer" do
      execute_script('window.scrollBy(0,10000)')
      expect(page).to have_link 'Twitter'
      expect(page).to have_link 'Facebook'
      expect(page).to have_link 'Pinterest'
    end
  end

  describe "#about" do
    it "show about page" do
      visit about_path
      expect(page).to have_link 'ぐるぐるマップから探す', href: '/'
      expect(page).to have_link '一覧から探す', href: '/spots'
      expect(page).to have_link 'イベントから探す', href: '/events'
      expect(page).to have_link 'おすすめルートから探す', href: '/routes'
      expect(page).to have_link 'お問い合わせ', href: '/contact/new'
      expect(page).to have_link 'よくある質問', href: '/help'
    end
  end
end
