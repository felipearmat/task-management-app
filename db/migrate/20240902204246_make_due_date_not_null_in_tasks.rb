class MakeDueDateNotNullInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tasks, :due_date, false
  end
end
