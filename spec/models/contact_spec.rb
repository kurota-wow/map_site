require 'rails_helper'

RSpec.describe Contact do
  let!(:contact) { build(:contact) }

  describe 'attribute: name' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'attribute: email' do
    it { is_expected.to validate_presence_of :email }

    context 'when correct format' do
      it 'is valid email' do
        contact.email = 'user@example.com'
        expect(contact).to be_valid

        contact.email = 'USER@EXAMPLE.COM'
        expect(contact).to be_valid

        contact.email = 'A_US-ER@foo.bar.org'
        expect(contact).to be_valid
      end
    end

    context 'when is incorrect format' do
      it 'is invalid' do
        contact.email = 'user@example,com'
        expect(contact).to be_invalid

        contact.email = 'user_example,com'
        expect(contact).to be_invalid

        contact.email = 'user..name@example'
        expect(contact).to be_invalid
      end
    end
  end

  describe 'attribute: message' do
    it { is_expected.to validate_presence_of :message }

    context 'when length is 100 characters or less' do
      it 'is valid' do
        contact.message = 'a' * 100
        expect(contact).to be_valid
      end
    end

    context 'when length is more than 100 characters' do
      it 'is invalid' do
        contact.message = 'a' * 101
        expect(contact).to be_invalid
        expect(contact.errors[:message]).to include("は100文字以内で入力してください")
      end
    end
  end
end
