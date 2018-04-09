class AddColumnToOccurredDate < ActiveRecord::Migration[5.1]
  def change
    add_column :occurred_dates, :occurred_at, :datetime
  end
end
