require 'rails_helper'

RSpec.describe Customer do
  let!(:customer) { create(:customer) }
  let!(:spot) { create(:spot) }

  it "is valid with valid attributes" do
    expect(customer).to be_valid
  end

  it "is not valid without a name" do
    customer.name = nil
    expect(customer).not_to be_valid
  end

  it "has many spot comments" do
    expect(described_class.reflect_on_association(:spot_comments).macro).to eq(:has_many)
  end

  it "has many bookmarks" do
    expect(described_class.reflect_on_association(:bookmarks).macro).to eq(:has_many)
  end

  it "has many bookmark_spots" do
    expect(described_class.reflect_on_association(:bookmark_spots).macro).to eq(:has_many)
  end

  it "can bookmark a spot" do
    customer.bookmark(spot)
    expect(customer.bookmark_spots).to include(spot)
  end

  it "can unbookmark a spot" do
    customer.bookmark(spot)
    customer.unbookmark(spot)
    expect(customer.bookmark_spots).not_to include(spot)
  end

  it "returns true if a spot is bookmarked" do
    customer.bookmark(spot)
    expect(customer).to be_bookmark(spot)
  end

  it "returns false if a spot is not bookmarked" do
    expect(customer).not_to be_bookmark(spot)
  end
end
