class AddStringToCategory < ActiveRecord::Migration
  def change
   change_column :categories, :avatar, :longblob
  end
end
