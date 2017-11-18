class Profile < ApplicationRecord

  validates :user_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :name,                        presence: true,
                                          length: { maximum: 100 }

  validates :description,                 length: { maximum: 500 }


	belongs_to :user

	has_many :experience,     dependent: :destroy
  has_many :education,      dependent: :destroy
  has_many :skill,          dependent: :destroy
  has_many :post, 				  dependent: :destroy
  has_many :notification,   dependent: :destroy
  has_many :comment
  has_many :likes

end
