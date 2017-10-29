class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :rental, index: true, foreign_key: true, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :client_email, null: false
      t.float :price, null: false

      t.timestamps null: false
    end
  end
end
