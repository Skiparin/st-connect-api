class Like < ApplicationRecord

  validates :user_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :post_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }


  after_save :increment_likes_in_post, if: :new_record

  after_destroy :decrement_likes_in_post

                                          

  has_one :post
  has_one :user

  private
    def increament_likes_in_post
      self.post.number_of_likes += 1 
    end

    def decrement_likes_in_post
      self.post.number_of_likes -= 1 
    end
end
