require 'rails_helper'

RSpec.describe SpotComment do
  let!(:customer) { create(:customer) }
  let!(:spot) { create(:spot) }
  let!(:valid_attributes) { { customer:, spot:, content: "Valid comment content" } }

  it "is valid with valid attributes" do
    expect(described_class.new(valid_attributes)).to be_valid
  end

  it "is not valid without content" do
    comment = described_class.new(valid_attributes.merge(content: nil))
    expect(comment).not_to be_valid
  end

  it "is not valid with content less than 5 characters" do
    comment = described_class.new(valid_attributes.merge(content: "1234"))
    expect(comment).not_to be_valid
  end

  it "is not valid with content more than 140 characters" do
    comment = described_class.new(valid_attributes.merge(content: "a" * 141))
    expect(comment).not_to be_valid
  end

  it "belongs to a customer" do
    expect(described_class.reflect_on_association(:customer).macro).to eq(:belongs_to)
  end

  it "belongs to a spot" do
    expect(described_class.reflect_on_association(:spot).macro).to eq(:belongs_to)
  end
end
