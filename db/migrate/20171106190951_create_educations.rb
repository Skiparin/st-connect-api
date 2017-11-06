class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations do |t|
    	t.string :degree, null: false
    	t.string :school, null: false
    	t.string :field_of_study, null: false
    	t.string :location, null: false
    	t.string :start_time, null: false
    	t.string :end_time, null: false
    	t.boolean :is_still_working, null: false, default: true
    	t.string :description, null: true
      t.timestamps
    end
  end
end
