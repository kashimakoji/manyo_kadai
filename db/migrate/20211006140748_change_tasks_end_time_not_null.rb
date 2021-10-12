class ChangeTasksEndTimeNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :end_time, :datetime, null: false, default: CURRENT_TIMESTAMP
  end
end
