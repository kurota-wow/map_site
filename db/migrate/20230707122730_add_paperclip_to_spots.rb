class AddPaperclipToSpots < ActiveRecord::Migration[7.0]
  def change
    remove_column :spots, :image
    add_column :spots, :category, :string
    add_attachment :spots, :image
  end
end
