class AddNewColumnToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :city, :string
  end
end
