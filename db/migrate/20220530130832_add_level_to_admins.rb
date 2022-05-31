class AddLevelToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :level, :integer
  end
end
