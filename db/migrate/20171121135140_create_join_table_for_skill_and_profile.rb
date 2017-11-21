class CreateJoinTableForSkillAndProfile < ActiveRecord::Migration[5.1]
  def change
    create_join_table :skills, :profiles do |t|
      t.index :profile_id
      t.index :skill_id
    end
  end
end
