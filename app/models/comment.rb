class Comment < ApplicationRecord

  validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :post_id,                     presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }


  after_create :make_notifications

  belongs_to :post
  belongs_to :profile

  private
    def make_notifications
      message = "A User has commented on a post."
      n_type = 0
      resource = "/posts/" + self.post.id.to_s
      self.post.comment.each do |c|
        n = Notification.new(profile_id: c.profile.id, message: message, n_type: n_type, resource: resource).save! if self.profile.id != c.profile.id
      end
    end
end
