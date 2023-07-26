require 'rails_helper'
RSpec.describe "Admin", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "GET /admin" do
    context "when logged in" do
      it "responds successfully" do
        sign_in @user
        get admin_root_path
        expect(response).to be_successful
        expect(response).to have_http_status(200)
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
