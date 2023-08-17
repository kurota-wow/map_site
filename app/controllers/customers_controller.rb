class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show]
  before_action :check_owner, only: [:show]

  def show
    @customer_comments = @customer.spot_comments.includes(:spot).order(:spot_id).page(params[:page]).per(5)
    bookmarks = Bookmark.where(customer_id: current_customer.id).pluck(:spot_id)
    @bookmark_list = Spot.where(id: bookmarks).page(params[:page]).per(7)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def check_owner
    redirect_to root_path unless @customer == current_customer
  end
end
