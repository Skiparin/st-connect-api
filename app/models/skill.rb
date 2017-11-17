class Skill < ApplicationRecord
  
	validates :profile_id,             			presence: true,
                                  				numericality: { greater_than_or_equal_to: 0 }

  validates :name,               					presence: true,
                                  				length: { maximum: 50 }

  validates :description,         				presence: true,
                                  				length: { maximum: 50 }

  belongs_to :profile
end
