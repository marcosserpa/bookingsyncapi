class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :rental, index: true, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.string :client_email
      t.float :price

      t.timestamps null: false
    end
  end
end
