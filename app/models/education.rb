class Education < ApplicationRecord
	
	validates :user_id,             				presence: true,
                                  				numericality: { greater_than_or_equal_to: 0 }

  validates :degree,               				presence: true,
                                  				length: { maximum: 50 }

  validates :school,         							presence: true,
                                  				length: { maximum: 50 }

  validates :field_of_study,            	presence: true,
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

  has_one :user

end
