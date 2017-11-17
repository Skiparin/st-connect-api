class Profile < ApplicationRecord

	belongs_to :user

	has_many :experience,   dependent: :destroy
  has_many :education,    dependent: :destroy
  has_many :skill,        dependent: :destroy
  has_many :post, 				dependent: :destroy
  has_many :comment
  has_many :likes

end
