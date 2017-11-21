class Skill < ApplicationRecord
  
  validates :name,               					presence: true,
                                  				length: { maximum: 50 }

  validates :description,         				presence: true,
                                  				length: { maximum: 50 }

  has_and_belongs_to_many :profile
end
