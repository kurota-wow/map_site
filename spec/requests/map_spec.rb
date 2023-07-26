require 'rails_helper'

RSpec.describe "Maps", type: :request do
  describe 'GET #show' do
    it 'renders the map successfully' do
      spot = FactoryBot.create(:spot, :with_icon)
      get spot_path(spot.id)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end