require 'rails_helper'

RSpec.describe "Customers" do
  let!(:customer) { create(:customer) }
  let!(:other_customer) { create(:customer, email: "test@email.com") }
  let!(:spot) { create(:spot) }

  describe 'GET #show' do
    context 'when signed in as the current customer' do
      before do
        customer.confirm
        sign_in(customer)
        get customer_path(customer.id)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'assigns the correct customer to @customer' do
        expect(assigns(:customer)).to eq(customer)
      end

      it 'assigns the customer comments to @customer_comments' do
        comment = create(:spot_comment, customer:, spot:)
        get customer_path(customer.id)
        expect(assigns(:customer_comments)).to eq([comment])
      end

      it 'assigns the bookmarked spots to @bookmark_list' do
        create(:bookmark, customer:, spot:)
        get customer_path(customer.id)
        expect(assigns(:bookmark_list)).to eq([spot])
      end

      it 'renders the correct tab content' do
        expect(response.body).to include('<div class="tab-content user-tab active">')
      end
    end

    context 'when signed in as a different customer' do
      before do
        other_customer.confirm
        sign_in(other_customer)
      end

      it 'redirects to the root path' do
        get customer_path(customer.id)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when not signed in' do
      it 'redirects to the sign-in page' do
        get customer_path(customer.id)
        expect(response).to redirect_to(new_customer_session_path)
      end
    end
  end
end
