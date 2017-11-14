class AddLikesToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :number_of_likes, :integer, null: false, default: 0
  end
end
