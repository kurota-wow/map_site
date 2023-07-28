require 'rails_helper'

RSpec.describe "Routing" do
  it "routes root path correctly" do
    expect(get: "/").to route_to(controller: "static_pages", action: "home")
  end

  it "routes /help to static_pages#help" do
    expect(get: "/help").to route_to(controller: "static_pages", action: "help")
  end

  it "routes /about to static_pages#about" do
    expect(get: "/about").to route_to(controller: "static_pages", action: "about")
  end

  it "routes /events to events#index" do
    expect(get: "/events").to route_to(controller: "events", action: "index")
  end

  it "routes /events/1 to events#show" do
    expect(get: "/events/1").to route_to(controller: "events", action: "show", id: "1")
  end

  it "routes /spots to spots#index" do
    expect(get: "/spots").to route_to(controller: "spots", action: "index")
  end

  it "routes /spots/1 to spots#show" do
    expect(get: "/spots/1").to route_to(controller: "spots", action: "show", id: "1")
  end

  it "routes /contact/new to contact#new" do
    expect(get: "/contact/new").to route_to(controller: "contact", action: "new")
  end

  it "routes POST /contact to contact#create" do
    expect(post: "/contact").to route_to(controller: "contact", action: "create")
  end

  it "routes POST /contact/confirm to contact#confirm" do
    expect(post: "/contact/confirm").to route_to(controller: "contact", action: "confirm")
  end

  it "routes GET /thanks to contact#thanks" do
    expect(get: "/thanks").to route_to(controller: "contact", action: "thanks")
  end

  it "routes /routes to route_search#index" do
    expect(get: "/routes").to route_to(controller: "route_search", action: "index")
  end

  describe "route for device" do
    it "routes /users/sign_in to devise/sessions#new" do
      expect(get: "/users/sign_in").to route_to(controller: "devise/sessions", action: "new")
    end
  end

  describe "route for admin user" do
    it "routes /admin/events to admin/events#index" do
      expect(get: "/admin/events").to route_to(controller: "admin/events", action: "index")
    end

    it "routes /admin/events/1 to admin/events#show" do
      expect(get: "/admin/events/1").to route_to(controller: "admin/events", action: "show", id: "1")
    end

    it "routes /admin/events/1/image to admin/events#destroy_image" do
      expect(delete: "/admin/events/1/image").to route_to(controller: "admin/events", action: "destroy_image", id: "1")
    end

    it "routes /admin/spots/1/icon to admin/spots#destroy_icon" do
      expect(delete: "/admin/spots/1/icon").to route_to(controller: "admin/spots", action: "destroy_icon", id: "1")
    end
  end
end
