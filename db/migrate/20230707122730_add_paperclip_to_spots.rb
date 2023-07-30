class AddPaperclipToSpots < ActiveRecord::Migration[7.0]
  def change
    remove_column :spots, :image
    add_column :spots, :category, :string
  end
end
