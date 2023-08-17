require 'rails_helper'

RSpec.describe "URL Helpers" do
  it "generates the admin root path correctly" do
    expect(admin_root_path).to eq("/admin")
  end

  it "generates the user log in path correctly" do
    expect(new_user_session_path).to eq("/users/sign_in")
  end

  describe "routes in header" do
    it "generates the root path correctly" do
      expect(root_path).to eq("/")
    end

    it "generates the events index path correctly" do
      expect(events_path).to eq("/events")
    end

    it "generates the spots index path correctly" do
      expect(spots_path).to eq("/spots")
    end

    it "generates the routes path correctly" do
      expect(routes_path).to eq("/routes")
    end

    it "generates the customer registration path correctly" do
      expect(new_customer_registration_path).to eq("/customers/sign_up")
    end

    it "generates the customer log in path correctly" do
      expect(new_customer_session_path).to eq("/customers/sign_in")
    end

    it "generates the guest sign in path correctly" do
      expect(customers_guest_sign_in_path).to eq("/customers/guest_sign_in")
    end

    it "generates the customer log out path correctly" do
      expect(destroy_customer_session_path).to eq("/customers/sign_out")
    end
  end

  describe "routes in footer" do
    it "generates the help path correctly" do
      expect(help_path).to eq("/help")
    end

    it "generates the about path correctly" do
      expect(about_path).to eq("/about")
    end

    it "generates the contact new path correctly" do
      expect(new_contact_path).to eq("/contact/new")
    end
  end
end
