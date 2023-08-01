require 'rails_helper'

RSpec.describe Spot do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to have_one_attached :icon }

    context "when icon attached with" do
      it "is valid icon" do
        spot = build(:spot, :with_icon)
        expect(spot.icon).to be_valid
      end

      it "is invalid icon" do
        spot_attached_not_icon = build(:spot, :with_not_icon)
        spot_attached_not_icon.valid?
        expect(spot_attached_not_icon.errors[:icon]).to include 'only jpg, jpeg, png, webp'
      end
    end

    it "is a valid latitude and longitude based on the address" do
      spot = create(:spot)
      lat = spot.latitude.to_f
      lng = spot.longitude.to_f
      expect(lat).to be_within(0.005).of 33.912750478
      expect(lng).to be_within(0.005).of 133.18760381
    end
  end

  describe "return search results from a string" do
    let!(:gourmet_spot) { create(:spot, name: "sample1", address: "Ehime", city: "1", category: "グルメ") }
    let!(:leisure_spot) { create(:spot, name: "sample2", address: "Dougo", city: "1", category: "レジャー") }
    let!(:sightseeing_spot) { create(:spot, name: "sample3", address: "Ehime", city: "3", category: "観光地") }

    context "when a match is found" do
      it "return spots that match the search area" do
        expect(described_class.get_area("1")).to include(gourmet_spot, leisure_spot)
      end

      it "return spots that match the search category" do
        expect(described_class.get_category("グルメ")).to include(gourmet_spot)
      end

      it "return spots that match the search keyword" do
        expect(described_class.get_keyword("Ehime")).to include(gourmet_spot, sightseeing_spot)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no results are found" do
        expect(described_class.get_area("4")).to be_empty
      end
    end

  end
end
