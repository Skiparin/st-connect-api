class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
    	t.integer :user_id
    	t.string :name, null: false
    	t.string :description, null: true, default: ""
    	t.string :image
      t.timestamps
    end
  end
end
