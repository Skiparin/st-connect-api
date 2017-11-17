class CreateNotificatons < ActiveRecord::Migration[5.1]
  def change
    create_table :notificatons do |t|
			t.integer  :profile_id,                 null: false
	    t.string   :message,                    null: false
	    t.integer  :n_type,                     null: false
	    t.boolean  :is_read,    default: false, null: false
			t.string 	 :resource
	    t.timestamps
    end
  end
end
