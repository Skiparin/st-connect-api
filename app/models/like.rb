class Like < ApplicationRecord

  validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :post_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }


  after_create :increment_likes_in_post # We only want the number of likes for a post to increase when we create an like

  after_destroy :decrement_likes_in_post # We want to decrease the number of likes when we destroy a like

                                          

  belongs_to :post
  belongs_to :profile

  private
    # Add one to the amount of likes in related post.
    def increment_likes_in_post
      self.post.number_of_likes += 1 
      self.post.save!
    end

    # Remove one from the amount of likes in related post.
    def decrement_likes_in_post
      self.post.number_of_likes -= 1 
      self.post.save!
    end
end
