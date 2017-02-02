class CreateEarthquakes < ActiveRecord::Migration[5.0]
  def change
    create_table :earthquakes, id: false do |t|
      t.string :id, null: false
      t.string :location, null: false
      t.decimal :magnitude, precision: 3, scale: 2, null: false
      t.decimal :distance, precision: 6, scale: 3, null: false
      t.datetime :occurred_at, null: false

      t.timestamps
    end

    add_index :earthquakes, :id, unique: true
    add_index :earthquakes, :occurred_at
  end
end
