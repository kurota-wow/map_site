require 'rails_helper'

RSpec.describe "CustomerAuthentications" do
  let!(:customer) { create(:customer, email: "name@email.com") }
  let!(:customer_params) { attributes_for(:customer) }
  let!(:invalid_customer_params) { attributes_for(:customer, name: "") }

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    context 'when accessed with valid params' do
      it 'sends an authentication email' do
        post customer_registration_path, params: { customer: customer_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'succeeds in creating a customer' do
        expect do
          post customer_registration_path, params: { customer: customer_params }
        end.to change(Customer, :count).by 1
      end

      it 'redirects to the root_url' do
        post customer_registration_path, params: { customer: customer_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'when parameters are invalid' do
      it 'does not send an authentication email' do
        post customer_registration_path, params: { customer: invalid_customer_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'fails to create a customer' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_params }
        end.not_to change(Customer, :count)
      end

      it 'displays an error message' do
        post customer_registration_path, params: { customer: invalid_customer_params }
        expect(response.body).to include 'エラーが発生したため ユーザー は保存されませんでした。'
      end
    end
  end
end
