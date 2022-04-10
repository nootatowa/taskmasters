class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.text :reward
      t.integer :position
      t.integer :task_point
      t.timestamps
    end
  end
end
