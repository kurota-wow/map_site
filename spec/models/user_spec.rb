require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email" do
      email = "test@example.com"
      create(:user, email:)
      user = build(:user, email:)
      expect(user).not_to be_valid
    end
  end

  describe "Devise password validations" do
    it "is not valid without a password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is not valid with a short password" do
      user = build(:user, password: "short")
      expect(user).not_to be_valid
    end
  end
end
