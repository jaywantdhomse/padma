class ChangeImageToCategory < ActiveRecord::Migration
  def change
    add_column :products, :avatar, :string
    remove_column :products, :image, :binary
  end
end
