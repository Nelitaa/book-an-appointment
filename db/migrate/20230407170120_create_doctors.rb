class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialization
      t.string :city
      t.decimal :fee
      t.string :photo
      t.decimal :experience

      t.timestamps
    end
  end
end
