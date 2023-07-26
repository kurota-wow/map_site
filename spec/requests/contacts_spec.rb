require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe "Contacts", type: :request do
  after do
    ActionMailer::Base.deliveries.clear
  end

  describe '#create' do
    it 'send e-mail' do
      contact_params = FactoryBot.attributes_for(:contact)
      expect {
        post contact_index_path, params: { contact: contact_params }
      }.to change { ActionMailer::Base.deliveries.size }.by(2)
    end

    it 'is correct email' do
      contact_params = FactoryBot.attributes_for(:contact)
      post contact_index_path, params: { contact: contact_params }
      first_mail = ActionMailer::Base.deliveries.first
      last_mail = ActionMailer::Base.deliveries.last
      expect(first_mail.subject).to eq 'Webサイトより問い合わせが届きました'
      expect(last_mail.subject).to eq 'お問合せありがとうございます。'
      expect(first_mail.to).to eq [ENV['TOMAIL']]
      expect(last_mail.to).to eq [contact_params[:email]]
    end
  end
end
