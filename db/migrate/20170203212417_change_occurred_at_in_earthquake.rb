class ChangeOccurredAtInEarthquake < ActiveRecord::Migration[5.0]
  def change
    remove_index :earthquakes, :occurred_at
    remove_column :earthquakes, :occurred_at
    add_column :earthquakes, :occurred_on, :date
    add_index :earthquakes, :occurred_on
  end
end
