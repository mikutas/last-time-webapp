class AddColumnToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :first_occurred_at, :datetime
  end
end
