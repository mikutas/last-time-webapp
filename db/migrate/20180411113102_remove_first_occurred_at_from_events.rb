class RemoveFirstOccurredAtFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :first_occurred_at, :datetime
  end
end
