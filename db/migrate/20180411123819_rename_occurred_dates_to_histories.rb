class RenameOccurredDatesToHistories < ActiveRecord::Migration[5.1]
  def change
    rename_table :occurred_dates, :histories
  end
end
