class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :city
      t.string :address
      t.string :pincode
      t.text :message

      t.timestamps
    end
  end
end
