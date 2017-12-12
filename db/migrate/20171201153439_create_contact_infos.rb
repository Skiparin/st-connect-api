class CreateContactInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_infos do |t|
    	t.integer :profile_id, null: false
    	t.string  :email, null: true
    	t.string  :phone, null: true
    	t.string  :address, null: true
    	t.date 	  :date_of_birth, null: true 
      t.timestamps
    end
  end
end
