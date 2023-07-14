class RemoveImageFromSpots < ActiveRecord::Migration[7.0]
  def change
    remove_attachment :spots, :image
  end
end
