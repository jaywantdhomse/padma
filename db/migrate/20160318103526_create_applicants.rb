class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.integer :apply_for
      t.string :email
      t.integer :phone
      t.string :current_organization
      t.string :current_profile
      t.text :upload_cv

      t.timestamps
    end
  end
end
