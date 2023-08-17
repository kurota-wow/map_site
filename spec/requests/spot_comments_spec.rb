require 'rails_helper'

RSpec.describe "SpotComments", js: true do
  let!(:customer) { create(:customer) }
  let!(:spot) { create(:spot) }
  let!(:spot_comment) { create(:spot_comment, customer:, spot:) }

  describe 'POST #create' do
    context 'when logged in' do
      before do
        customer.confirm
        sign_in customer
      end

      context 'with valid attributes' do
        it 'creates a new spot comment' do
          expect do
            post spot_spot_comments_path(spot), params: { spot_comment: attributes_for(:spot_comment) }, xhr: true
          end.to change(SpotComment, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new spot comment' do
          expect do
            post spot_spot_comments_path(spot), params: { spot_comment: attributes_for(:spot_comment, content: nil) }, xhr: true
          end.not_to change(SpotComment, :count)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      before do
        customer.confirm
        sign_in customer
      end

      context 'when customer owns the comment' do
        it 'deletes the spot comment' do
          expect do
            delete spot_spot_comment_path(spot, spot_comment), xhr: true
          end.to change(SpotComment, :count).by(-1)
        end
      end

      context 'when customer does not own the comment' do
        let!(:other_customer) { create(:customer, email: "test@email.com") }
        let!(:other_spot_comment) { create(:spot_comment, customer: other_customer, spot:) }

        it 'does not delete the spot comment' do
          expect do
            delete spot_spot_comment_path(spot, other_spot_comment), xhr: true
          end.not_to change(SpotComment, :count)
        end
      end
    end

    context 'when not logged in' do
      it 'redirects to the login page' do
        delete spot_spot_comment_path(spot, spot_comment), xhr: true
        expect(response).to redirect_to root_path
      end
    end
  end
end
