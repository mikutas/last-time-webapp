class ModifyIndexofEvents < ActiveRecord::Migration[5.1]
  def change
    remove_index :events, [:user_id, :created_at]
    add_index :events, [:user_id, :occurred_at]
  end
end
