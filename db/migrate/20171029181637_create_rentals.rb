class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.string :name, null: false
      t.float :daily_rate, null: false

      t.timestamps null: false
    end
  end
end
