class RemoveExperiencePointFromAdmins < ActiveRecord::Migration[6.1]
  def change
    remove_column :admins, :experience_point, :string
  end
end
