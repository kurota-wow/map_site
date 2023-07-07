class AddDetailsToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :city, :string
    add_column :spots, :latitude, :float
    add_column :spots, :longitude, :float
  end
end
