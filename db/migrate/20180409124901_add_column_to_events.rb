class AddColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :occurred_at, :datetime
  end
end
