class ChangeAvatarTypeInCategory < ActiveRecord::Migration
  def change
    change_column :categories, :avatar, :blob
  end
end
