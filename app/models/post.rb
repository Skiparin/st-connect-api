class Post < ApplicationRecord

  validates :profile_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :text,                        presence: true,
                                          length: { maximum: 300 }


  has_many :like, dependent: :destroy
  has_many :comment, dependent: :destroy
  
  belongs_to :profile
end
