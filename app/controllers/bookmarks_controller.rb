class BookmarksController < ApplicationController
  before_action :authenticate_customer!

  before_action :set_spot

  def create
    current_customer.bookmark(@spot)

    response_data = {
      bookmarked: true,
      template: render_to_string(partial: 'spots/bookmark_button', locals: { spot: @spot })
    }

    respond_to do |format|
      format.json { render json: response_data }
      format.html do
        redirect_back fallback_location: root_path
      end
    end
  end

  def destroy
    current_customer.unbookmark(@spot)

    response_data = {
      bookmarked: false,
      template: render_to_string(partial: 'spots/bookmark_button', locals: { spot: @spot })
    }

    respond_to do |format|
      format.json { render json: response_data }
      format.html do
        redirect_back fallback_location: root_path
        flash.now[:success] = t('defaults.message.unbookmark')
      end
    end
  end

  private

  def set_spot
    @spot = Spot.find_by(id: params[:spot_id])
  end
end
