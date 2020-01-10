class AddLimitAndStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date
    add_column :tasks, :status, :string
  end
end
