require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "when accept argument" do
      it "is a valid title display" do
        expect(full_title('test')).to eq('test - ぐるぐるマップ愛媛')
      end
    end

    context "when accept Empty character" do
      it "is a valid title display" do
        expect(full_title('')).to eq('ぐるぐるマップ愛媛')
      end
    end

    context "when accept blank" do
      it "is a valid title display" do
        expect(full_title(' ')).to eq('ぐるぐるマップ愛媛')
      end
    end

    context "when accept nil" do
      it "is a valid title display" do
        expect(full_title(nil)).to eq('ぐるぐるマップ愛媛')
      end
    end
  end
end