class Like < ApplicationRecord

  validates :user_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :post_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

                                          

  has_one :post
  has_one :user
end
