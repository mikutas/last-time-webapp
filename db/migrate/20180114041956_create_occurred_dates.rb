class CreateOccurredDates < ActiveRecord::Migration[5.1]
  def change
    create_table :occurred_dates do |t|
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
