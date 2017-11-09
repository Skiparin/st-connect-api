class Skill < ApplicationRecord
  
	validates :user_id,             				presence: true,
                                  				numericality: { greater_than_or_equal_to: 0 }

  validates :name,               					presence: true,
                                  				length: { maximum: 50 }

  validates :description,         				presence: true,
                                  				length: { maximum: 50 }

  has_one :user
end
