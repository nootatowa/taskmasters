class CreateTaskTags < ActiveRecord::Migration[6.1]
  def change
    create_table :task_tags do |t|

      t.timestamps
    end
  end
end
