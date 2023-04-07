class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null:false, foreign_key: {to_table: 'users'}, index: true
      t.references :doctor, null:false, foreign_key: {to_table: 'doctors'}, index: true
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
