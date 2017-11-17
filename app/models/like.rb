class Like < ApplicationRecord

  validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :post_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }


  after_save :increment_likes_in_post

  after_destroy :decrement_likes_in_post

                                          

  belongs_to :post
  belongs_to :profile

  private
    def increment_likes_in_post
      # Need to check if the record is new, since we can't use new_record in a after_save.
      if self.created_at == self.updated_at
        self.post.number_of_likes += 1 
        self.post.save!
      end
    end

    def decrement_likes_in_post
      self.post.number_of_likes -= 1 
      self.post.save!
    end
end
