class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.text :reward
      t.integer :position
      t.integer :task_point
<<<<<<< HEAD
      t.string :privacy
      t.string :status
=======
>>>>>>> ba90e9bb6192786418e88fafae891f37f3ada2c0
      t.references :customer, foreign_key: true, null: false
      t.timestamps
    end
  end
end
