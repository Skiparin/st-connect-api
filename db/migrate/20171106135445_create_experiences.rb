class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.integer :user_id
    	t.string :title, null: false
    	t.string :company, null: true
    	t.string :location, null: false
    	t.string :start_time, null: false
    	t.string :end_time, null: false
    	t.boolean :is_still_working, null: false, default: true
    	t.string :description, null: true
      t.timestamps
    end
  end
end
