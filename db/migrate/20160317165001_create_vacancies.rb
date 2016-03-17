class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :post
      t.string :experience
      t.string :skills

      t.timestamps
    end
  end
end
