require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe "Contacts" do
  after do
    ActionMailer::Base.deliveries.clear
  end

  describe "GET #new" do
    it "returns http success" do
      get new_contact_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let!(:valid_params) { attributes_for(:contact) }

      it "redirects to the confirm page" do
        post confirm_path, params: { contact: valid_params }
        expect(response).to have_http_status(:success)
        expect(response.body).to include(valid_params[:name])
        expect(response.body).to include(valid_params[:email])
        expect(response.body).to include(valid_params[:message])
      end

      it "redirects to the new page with click on back" do
        post contact_index_path, params: { contact: valid_params, back: true }
        expect(response).to render_template(:new)
      end

      it "redirects to the thanks page" do
        post contact_index_path, params: { contact: valid_params }
        expect(response).to redirect_to(thanks_path)
      end

      it "sends two emails" do
        expect {
          post contact_index_path, params: { contact: valid_params }
        }.to change { ActionMailer::Base.deliveries.size }.by(2)
      end

      it "sends correct emails" do
        post contact_index_path, params: { contact: valid_params }
        first_mail = ActionMailer::Base.deliveries.first
        last_mail = ActionMailer::Base.deliveries.last
        expect(first_mail.subject).to eq 'Webサイトより問い合わせが届きました'
        expect(last_mail.subject).to eq 'お問合せありがとうございます。'
        expect(first_mail.to).to eq [ENV.fetch('TOMAIL', nil)]
        expect(last_mail.to).to eq [valid_params[:email]]
      end
    end

    context "with invalid parameters" do
      let!(:invalid_params) { attributes_for(:contact, name: nil) }

      it "renders the new template" do
        post confirm_path, params: { contact: invalid_params }
        expect(response).to render_template(:new)
      end

      it "renders the new template with direct access" do
        post contact_index_path, params: { contact: invalid_params }
        expect(response).to redirect_to(new_contact_path)
      end

      it "does not send any email" do
        expect {
          post contact_index_path, params: { contact: invalid_params }
        }.not_to(change { ActionMailer::Base.deliveries.size })
      end
    end
  end
end
