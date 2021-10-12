class ChangeTasksEndTimeDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :end_time, from: DateTime.now, to: 'NOW()'
  end
end
