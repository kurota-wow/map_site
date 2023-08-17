require 'rails_helper'

RSpec.describe "Bookmarks", js: true do
  let!(:customer) { create(:customer) }
  let!(:spot) { create(:spot) }

  describe 'POST #create' do
    context 'when logged in' do
      before do
        customer.confirm
        sign_in customer
      end

      it 'creates a bookmark' do
        expect do
          post spot_bookmarks_path(spot.id), xhr: true
        end.to change(Bookmark, :count).by(1)
      end
    end

    context 'when not logged in' do
      it 'returns a 401 Unauthorized status' do
        post spot_bookmarks_path(spot.id), xhr: true
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('ログインもしくはアカウント登録してください。')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      before do
        customer.confirm
        sign_in customer
        customer.bookmark(spot)
      end

      it 'removes a bookmark' do
        expect do
          delete spot_bookmarks_path(spot.id), xhr: true
        end.to change(Bookmark, :count).by(-1)
      end
    end
  end
end
