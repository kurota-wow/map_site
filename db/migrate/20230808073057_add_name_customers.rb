class AddNameCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :name, :string, null: false
  end
end
