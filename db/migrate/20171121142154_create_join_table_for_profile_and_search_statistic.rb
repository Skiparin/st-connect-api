class CreateJoinTableForProfileAndSearchStatistic < ActiveRecord::Migration[5.1]
  def change
    create_join_table :search_statistics, :profiles do |t|
      t.index :profile_id
      t.index :search_statistic_id
    end
  end
end
