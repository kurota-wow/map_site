require 'rails_helper'

RSpec.describe "Admin" do
  describe "GET /admin" do
    context "when logged in" do
      before do
        user = create(:user)
        sign_in user
      end

      it "responds successfully" do
        get admin_root_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context "when not logged in" do
      it "redirect to login screen" do
        get admin_root_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
