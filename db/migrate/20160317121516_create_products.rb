class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.string :model
      t.integer :price
      t.binary :image
      t.text :description

      t.timestamps
    end
  end
end
