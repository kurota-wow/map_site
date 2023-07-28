require 'rails_helper'

RSpec.describe "Events" do
  describe "GET #index" do
    it "returns http success" do
      get events_path
      expect(response).to have_http_status(:success)
    end

    it "displays events" do
      create(:event, name: "Spring Event", season: "春")
      get events_path
      expect(response.body).to include("Spring Event")
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      event = create(:event)
      get event_path(event.id)
      expect(response).to have_http_status(:success)
    end

    it "displays event details" do
      event = create(:event, name: "Test Event", address: "Test Address", content: "Test Content")
      get event_path(event.id)
      expect(response.body).to include("Test Event")
      expect(response.body).to include("Test Address")
      expect(response.body).to include("Test Content")
    end
  end
end
