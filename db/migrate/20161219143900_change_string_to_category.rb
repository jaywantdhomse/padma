class ChangeStringToCategory < ActiveRecord::Migration
  def change
  	change_column :categories, :avatar, :string
  end
end
