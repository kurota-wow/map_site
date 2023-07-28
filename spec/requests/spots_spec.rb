require 'rails_helper'

RSpec.describe "Spots" do
  describe "GET #index" do
    it "returns http success" do
      get spots_path
      expect(response).to have_http_status(:success)
    end

    it "displays spots in the view" do
      spot1 = create(:spot, name: "Spot 1")
      spot2 = create(:spot, name: "Spot 2")
      get spots_path
      expect(response.body).to include(spot1.name)
      expect(response.body).to include(spot2.name)
    end

    it "filters spots by area" do
      spot1 = create(:spot, name: "Spot 1", city: "1")
      spot2 = create(:spot, name: "Spot 2", city: "2")
      get spots_path, params: { area: "1" }
      expect(response.body).to include(spot1.name)
      expect(response.body).not_to include(spot2.name)
    end

    it "filters spots by category" do
      spot1 = create(:spot, name: "Spot 1", category: "観光地")
      spot2 = create(:spot, name: "Spot 2", category: "レジャー")
      get spots_path, params: { category: "観光地" }
      expect(response.body).to include(spot1.name)
      expect(response.body).not_to include(spot2.name)
    end

    it "filters spots by keyword" do
      spot1 = create(:spot, name: "Spot 1", content: "This is a great spot!")
      spot2 = create(:spot, name: "Spot 2", content: "Awesome location")
      get spots_path, params: { keyword: "great" }
      expect(response.body).to include(spot1.name)
      expect(response.body).not_to include(spot2.name)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      spot = create(:spot)
      get spot_path(spot.id)
      expect(response).to have_http_status(:success)
    end

    it "displays spot details in the view" do
      spot = create(:spot, name: "Spot 1", address: "Ehime", content: "This is a great spot!")
      get spot_path(spot.id)
      expect(response.body).to include(spot.name)
      expect(response.body).to include(spot.address)
      expect(response.body).to include(spot.content)
    end
  end
end
