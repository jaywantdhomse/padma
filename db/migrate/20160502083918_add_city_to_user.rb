class AddCityToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :pincode, :string
    add_column :users, :address, :text
  end
end
