class ContactInfo < ApplicationRecord

	validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :email,                       presence: true,
                                          length: { maximum: 100 }

  validates :phone, 											presence: true,
                                          length: { maximum: 100 }

  validates :address, 										presence: true,
                                          length: { maximum: 100 }


	belongs_to :profile
end
