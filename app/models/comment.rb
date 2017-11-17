class Comment < ApplicationRecord

  validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :post_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  belongs_to :post
  belongs_to :profile
end
