class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.text :content
      t.string :name
      t.string :address
      t.string :season
      t.string :image

      t.timestamps
    end
  end
end
