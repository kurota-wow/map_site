class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :image
      t.string :address
      t.text :content

      t.timestamps
    end
  end
end
