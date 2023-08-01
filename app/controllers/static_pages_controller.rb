class StaticPagesController < ApplicationController

  def home
    respond_to do |format|
      format.html
      format.jpeg do
        response.headers["Cache-Control"] = "public, max-age=3600"
        send_data image_data, type: "image/jpeg", disposition: "inline"
      end
    end
  end

  def help
  end

  def about
  end
end
