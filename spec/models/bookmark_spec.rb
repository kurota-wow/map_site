require 'rails_helper'

RSpec.describe Bookmark do
  let!(:spot) { create(:spot) }
  let!(:customer) { create(:customer) }

  describe 'associations' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:spot) }
  end

  describe 'validations' do
    let!(:bookmark) { described_class.new(customer:, spot:) }

    context 'when the same bookmark already exists' do
      before do
        described_class.create(customer:, spot:)
      end

      it 'is not valid' do
        expect(bookmark).not_to be_valid
        expect(bookmark.errors[:customer_id]).to include('はすでに存在します')
      end
    end

    context 'when a different bookmark exists' do
      let!(:other_customer) { create(:customer, email: "test@example.com") }

      before do
        described_class.create(customer: other_customer, spot:)
      end

      it 'is valid' do
        expect(bookmark).to be_valid
      end
    end
  end
end
