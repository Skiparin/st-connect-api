class CreateSearchStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :search_statistics do |t|
    	t.string :search_string, null: false
    	t.string :target, null: false
    	t.integer :number_of_searches, null: false, default: 0
      t.timestamps
    end
  end
end
