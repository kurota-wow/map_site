class SpotsController < ApplicationController
  def index
    @spots = Rails.cache.fetch('spots', expires_in: 1.hour) do
      Spot.with_attached_icon.order(id: :asc)
    end
    @spots = @spots.get_area(params[:area]) if params[:area].present?
    @spots = @spots.get_category(params[:category]) if params[:category].present?
    @spots = @spots.get_keyword(params[:keyword]) if params[:keyword].present?
    @areas = [['東予', 1], ['中予', 2], ['南予', 3]]
    @categories = [['観光地', '観光地'], ['レジャー', 'レジャー'], ['歴史', '歴史'], ['お土産', 'お土産'], ['グルメ', 'グルメ']]
  end

  def show
    @spot = Spot.find(params[:id])
    @spot_comment = SpotComment.new
    @spot_comments = @spot.spot_comments.includes(:customer).order(created_at: :desc).page(params[:page]).per(5)
  end
end
