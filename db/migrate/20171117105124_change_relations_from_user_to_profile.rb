class ChangeRelationsFromUserToProfile < ActiveRecord::Migration[5.1]
  def change
  	rename_column :comments, :user_id, :profile_id 
  	rename_column :educations, :user_id, :profile_id 
  	rename_column :experiences, :user_id, :profile_id 
  	rename_column :likes, :user_id, :profile_id 
  	rename_column :posts, :user_id, :profile_id 
  	rename_column :skills, :user_id, :profile_id 
  end
end
