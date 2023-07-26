require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to have_one_attached :icon }

    context "when icon attached with" do
      it "is valid icon" do
        spot = FactoryBot.build(:spot, :with_icon)
        expect(spot.icon).to be_valid
      end

      it "is invalid icon" do
        spot_attached_not_icon = FactoryBot.build(:spot, :with_not_icon)
        spot_attached_not_icon.valid?
        expect(spot_attached_not_icon.errors[:icon]).to include 'only jpg, jpeg, png'
      end
    end

    it "is a valid latitude and longitude based on the address" do
      spot = FactoryBot.create(:spot)
      lat = spot.latitude.to_f
      lng = spot.longitude.to_f
      expect(lat).to be_within(0.005).of 33.912750478
      expect(lng).to be_within(0.005).of 133.18760381
    end
  end

  describe "return search results from a string" do
    before do
      @spot1 = Spot.create(
        name: "道の駅",
        address: "愛媛県四国中央市",
        city: "1",
        category: "グルメ",
      )
      @spot2 = Spot.create(
        name: "焼き鳥",
        address: "愛媛県今治市",
        city: "1",
        category: "グルメ",
      )
      @spot3 = Spot.create(
        name: "下灘駅",
        address: "愛媛県伊予市",
        city: "3",
        category: "観光地",
      )
    end

    context "when a match is found" do

      it "return spots that match the search area" do
        expect(Spot.get_area("1")).to include(@spot1, @spot2)
      end

      it "return spots that match the search category" do
        expect(Spot.get_category("グルメ")).to include(@spot1, @spot2)
      end

      it "return spots that match the search keyword" do
        expect(Spot.get_keyword("駅")).to include(@spot1, @spot3)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no results are found" do
        expect(Spot.get_area("4")).to be_empty
      end
    end

  end
end
