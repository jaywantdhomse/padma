class AddAvatarToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :avatar, :string
  end
end
