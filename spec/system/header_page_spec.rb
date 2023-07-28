require 'rails_helper'

RSpec.describe "Header" do
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
    expect(page).to have_selector(".responsive_btn")
    find(".responsive_btn").click
    expect(page).to have_selector(".header_nav")
  end

  it "has correct links in the navigation menu" do
    visit root_path
    find(".responsive_btn").click
    expect(page).to have_link("ぐるぐるマップ", href: root_path)
    expect(page).to have_link("スポット", href: spots_path)
    expect(page).to have_link("イベント", href: events_path)
    expect(page).to have_link("おすすめルート", href: routes_path)
  end
end
