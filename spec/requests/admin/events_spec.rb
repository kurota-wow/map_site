require 'rails_helper'

RSpec.describe "Admin::Events" do
  before do
    user = create(:user)
    sign_in user
    get admin_root_path
  end

  describe "GET /admin/events/new" do
    context "with valid attributes" do
      it "adds a event" do
        get new_admin_event_path
        event_params = attributes_for(:event)
        expect {
          post admin_events_path, params: { event: event_params }
        }.to change(Event, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not add a event" do
        get new_admin_event_path
        event_params = attributes_for(:event, :invalid)
        expect {
          post admin_events_path, params: { event: event_params }
        }.not_to change(Event, :count)
      end
    end
  end

  describe "GET /admin/events/:id/edit" do
    it "updates a event" do
      event = create(:event)
      get edit_admin_event_path(event.id)
      event_params = attributes_for(:event, name: "new name")
      patch admin_event_path, params: { event: event_params }
      expect(event.reload.name).to eq "new name"
    end
  end

  describe "DELETE /admin/events/:id" do
    it "destory a event" do
      event = create(:event)
      expect {
        delete "/admin/events/" + event.id.to_s
      }.to change(Event, :count).by(-1)
    end
  end
end
