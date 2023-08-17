class SpotCommentsController < ApplicationController
  def create
    spot_comment = current_customer.spot_comments.build(comment_params)

    if spot_comment.save
      respond_to do |format|
        format.json { render json: { spot_comment:, customer_name: current_customer.name, success: true } }
        format.html { redirect_to spot_path(spot_comment.spot) }
      end
    else
      respond_to do |format|
        format.json { render json: { spot_comment:, errors: spot_comment.errors.full_messages, success: false } }
        format.html { redirect_to spot_path(spot_comment.spot) }
      end
    end
  end

  def destroy
    spot_comment = SpotComment.find_by(id: params[:id], spot_id: params[:spot_id])

    if current_customer&.own?(spot_comment)
      if spot_comment.destroy
        respond_to do |format|
          format.json { render json: { success: true } }
          format.html { redirect_back fallback_location: root_path }
        end
      else
        respond_to do |format|
          format.json { render json: { success: false, errors: spot_comment.errors.full_messages } }
          format.html { redirect_back fallback_location: root_path, flash: { danger: "削除に失敗しました。" } }
        end
      end
    else
      respond_to do |format|
        format.json { render json: { success: false, errors: ["コメントを削除する権限がありません。"] } }
        format.html { redirect_back fallback_location: root_path, flash: { danger: "コメントを削除する権限がありません。" } }
      end
    end
  end

  private

  def comment_params
    params.require(:spot_comment).permit(:content).merge(spot_id: params[:spot_id])
  end
end
