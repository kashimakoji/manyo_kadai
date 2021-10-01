class ChangeTasksEndTimeNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :end_time, true
  end

  def down
    change_column_null :tasks, :end_time, false
  end
end
