class RemoveProfileIdFromSkills < ActiveRecord::Migration[5.1]
  def change
    remove_column :skills, :profile_id
  end
end
