require 'rails_helper'

RSpec.describe "Header" do
  let!(:customer) { create(:customer) }

  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [700, 700]
  end

  it "displays the logo and links to the root path" do
    visit root_path
    expect(page).to have_selector("img#logo")
    expect(find("img#logo")["alt"]).to eq "ぐるぐるマップ愛媛"
    expect(page).to have_link("ぐるぐるマップ愛媛", href: root_path)
  end

  it "toggles the header navigation with responsive button" do
    visit root_path
    expect(page).to have_selector(".responsive-btn")
    find(".responsive-btn").click
    expect(page).to have_selector(".header-nav")
  end

  it "has correct links in the navigation menu" do
    visit root_path
    find(".responsive-btn").click
    expect(page).to have_link("ぐるぐるマップ", href: root_path)
    expect(page).to have_link("スポット", href: spots_path)
    expect(page).to have_link("イベント", href: events_path)
    expect(page).to have_link("おすすめルート", href: routes_path)
  end

  it "has correct links for customers" do
    visit root_path
    find(".responsive-btn").click
    expect(page).to have_link("新規登録", href: new_customer_registration_path)
    expect(page).to have_link("ログイン", href: new_customer_session_path)
    expect(page).to have_button("ゲストログイン")
  end

  context 'when signed in' do
    before do
      customer.confirm
      sign_in(customer)
      visit root_path
    end

    it "has correct contents for customers" do
      find(".responsive-btn").click
      expect(page).to have_link("マイページ", href: customer_path(customer.id))
      expect(page).to have_button("ログアウト")
      expect(page).not_to have_link("新規登録", href: new_customer_registration_path)
      expect(page).not_to have_link("ログイン", href: new_customer_session_path)
      expect(page).not_to have_button("ゲストログイン")
    end
  end
end
