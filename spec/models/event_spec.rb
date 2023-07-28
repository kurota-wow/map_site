require 'rails_helper'

RSpec.describe Event do
  let!(:event) { described_class.new(name: "sample", season: "春") }

  describe 'validations' do
    it "is valid with a name, season" do
      expect(event).to be_valid
    end

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :season }
    it { is_expected.to have_one_attached :image }

    context "when image attached with" do
      it "is valid image" do
        event = build(:event, :with_image)
        expect(event.image).to be_valid
      end

      it "is invalid image" do
        event_attached_not_image = build(:event, :with_not_image)
        event_attached_not_image.valid?
        expect(event_attached_not_image.errors[:image]).to include 'only jpg, jpeg, png'
      end
    end
  end
end
