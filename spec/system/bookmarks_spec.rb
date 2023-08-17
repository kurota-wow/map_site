require 'rails_helper'

RSpec.describe 'Bookmarks' do
  let!(:customer) { create(:customer) }
  let!(:spot) { create(:spot) }

  before do
    driven_by(:selenium_chrome_headless)
  end

  context 'when logged in and visit spot show page' do
    before do
      customer.confirm
      sign_in customer
      visit spot_path(spot)
    end

    it 'displays the bookmark button' do
      expect(page).to have_selector('#unbookmark-button')
    end

    it 'creates a bookmark and reflects on index page' do
      bookmark_button = find("#bookmarked-button-container-#{spot.id}")
      bookmark_button.click
      expect(page).to have_selector('#bookmark-button')
      expect(page).to have_content('お気に入りに追加しました。')
      visit spots_path
      expect(page).to have_selector('#bookmark-button')
    end

    it 'deletes a bookmark' do
      bookmark_button = find("#bookmarked-button-container-#{spot.id}")
      bookmark_button.click
      bookmark_button.click
      expect(page).to have_selector('#unbookmark-button')
      expect(page).not_to have_selector('#bookmark-button')
      expect(page).to have_content('お気に入りから削除しました。')
    end
  end

  context 'when logged in and visit spots index page' do
    before do
      customer.confirm
      sign_in customer
      visit spots_path
    end

    it 'displays the number of spots bookmark button' do
      create(:spot)
      visit spots_path
      expect(page).to have_selector('#unbookmark-button', count: 2)
    end

    it 'creates a bookmark and destroy' do
      expect(page).to have_selector('#unbookmark-button')
      find_by_id('unbookmark-button').click
      expect(page).to have_content('お気に入りに追加しました。')
      expect(page).to have_selector('#bookmark-button')
      find_by_id('bookmark-button').click
      expect(page).to have_content('お気に入りから削除しました。')
    end
  end

  context 'when not logged in' do
    it 'does not display the bookmark button in show page' do
      visit spot_path(spot)
      expect(page).not_to have_selector('#unbookmark-button')
    end

    it 'does not display the bookmark button in index page' do
      visit spots_path
      expect(page).not_to have_selector('#unbookmark-button')
    end
  end
end
