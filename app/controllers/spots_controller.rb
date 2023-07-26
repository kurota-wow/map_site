class SpotsController < ApplicationController
  def index
    @spots = Spot.all
    if params[:area].present?
      @spots = @spots.get_area params[:area]
    end
    if params[:category].present?
      @spots = @spots.get_category params[:category]
    end
    if params[:keyword].present?
      @spots = @spots.get_keyword params[:keyword]
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

end
