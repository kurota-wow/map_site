class SpotsController < ApplicationController
  def index
    @spots = Spot.all
    @spots = @spots.get_area(params[:area]) if params[:area].present?
    @spots = @spots.get_category(params[:category]) if params[:category].present?
    @spots = @spots.get_keyword(params[:keyword]) if params[:keyword].present?
    @areas = [['東予', 1], ['中予', 2], ['南予', 3]]
    @categories = [['観光地', '観光地'], ['レジャー', 'レジャー'], ['歴史', '歴史'], ['お土産', 'お土産'], ['グルメ', 'グルメ']]

    respond_to do |format|
      format.html
      format.jpeg do
        response.headers["Cache-Control"] = "public, max-age=3600"
        send_data image_data, type: "image/jpeg", disposition: "inline"
      end
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end
end
