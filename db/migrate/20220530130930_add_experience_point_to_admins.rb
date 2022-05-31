class AddExperiencePointToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :experience_point, :string
  end
end
