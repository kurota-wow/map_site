class CreateSpotComments < ActiveRecord::Migration[7.0]
  def change
    create_table :spot_comments do |t|
      t.text :content, null: false
      t.references :customer, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
