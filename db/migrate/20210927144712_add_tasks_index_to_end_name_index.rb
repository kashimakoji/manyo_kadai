class AddTasksIndexToEndNameIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :end_time
  end
end
