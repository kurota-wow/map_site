class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true

      t.timestamps
      t.index [:customer_id, :spot_id], unique: true
    end
  end
end
