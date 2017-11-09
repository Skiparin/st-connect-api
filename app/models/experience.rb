class Experience < ApplicationRecord

	validates :user_id,             				presence: true,
                                  				numericality: { greater_than_or_equal_to: 0 }

  validates :title,               				presence: true,
                                  				length: { maximum: 50 }

  validates :company,         						presence: true,
                                  				length: { maximum: 50 }

	validates :location,            				presence: true,
																					length: { maximum: 50 }
																	
	validates :start_time,            			presence: true,
																					length: { maximum: 20 }																																

	validates :end_time,            				presence: true,
																					length: { maximum: 20 }
																	
	validates :description,            			presence: true,
																					length: { maximum: 150 }

	validates :is_still_working,            presence: true,
																					inclusion: { in: [ true, false ] }


																					t.integer "user_id"
    t.string "title", null: false
    t.string "company"
    t.string "location", null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.boolean "is_still_working", default: true, null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  has_one :user
end
