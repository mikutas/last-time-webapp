class ModifyIndexofOccurredDates < ActiveRecord::Migration[5.1]
  def change
    remove_index :occurred_dates, :created_at
    add_index :occurred_dates, :occurred_at
  end
end
