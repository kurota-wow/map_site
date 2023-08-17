class StaticPagesController < ApplicationController

  def home
    respond_to do |format|
      format.html
      format.jpeg do
        response.headers["Cache-Control"] = "public, max-age=30000"
        send_data image_data, type: "image/jpeg", disposition: "inline"
      end
    end
    @top_spots = Spot.joins(:bookmarks)
      .group('spots.id')
      .order('COUNT(bookmarks.id) DESC')
      .limit(3)
  end

  def help
  end

  def about
  end

end
