require 'rails_helper'

RSpec.describe "Admin::Spots", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    get admin_root_path
  end

  describe "GET /admin/spots/new" do
    context "with valid attributes" do
      it "adds a spot" do
        get new_admin_spot_path
        spot_params = FactoryBot.attributes_for(:spot)
        expect {
          post admin_spots_path, params: { spot: spot_params }
        }.to change(Spot, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not add a spot" do
        get new_admin_spot_path
        spot_params = FactoryBot.attributes_for(:spot, :invalid_spot)
        expect {
          post admin_spots_path, params: { spot: spot_params }
        }.to_not change(Spot, :count)
      end
    end
  end

  describe "GET /admin/spots/:id/edit" do
    it "updates a spot" do
      @spot = FactoryBot.create(:spot)
      get edit_admin_spot_path(@spot.id)
      spot_params = FactoryBot.attributes_for(:spot, name: "new name")
      patch admin_spot_path, params: { spot: spot_params }
      expect(@spot.reload.name).to eq "new name"
    end
  end

  describe "DELETE /admin/spots/:id" do
    it "destory a spot" do
      @spot = FactoryBot.create(:spot)
      expect {
        delete "/admin/spots/" + @spot.id.to_s
      }.to change(Spot, :count).by(-1)
    end
  end
end
