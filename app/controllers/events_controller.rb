class EventsController < ApplicationController
  def index
    @events_by_season = {
      spring: Event.where(season: "春"),
      summer: Event.where(season: "夏"),
      autumn: Event.where(season: "秋"),
      winter: Event.where(season: "冬")
    }
  end

  def show
    @event = Event.find(params[:id])
  end
end
