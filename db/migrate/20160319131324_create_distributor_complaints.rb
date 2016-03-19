class CreateDistributorComplaints < ActiveRecord::Migration
  def change
    create_table :distributor_complaints do |t|
      t.string :by
      t.string :name
      t.string :email
      t.string :phone
      t.string :city
      t.string :address
      t.string :pincode
      t.string :product
      t.string :model
      t.string :complaint

      t.timestamps
    end
  end
end
