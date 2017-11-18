class Notification < ApplicationRecord

  enum e_type: { 
                  new_comment: 0
               }

  validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :message,                     presence: true,
                                          length: { maximum: 50 }

  validates :n_type,                      presence: true

  validates :is_read,                     presence: true, unless: :new_record?,
                                          inclusion: { in: [ true, false ] }

  validates :resource,                    presence: true,
                                          length: { maximum: 100 }
                                  
  belongs_to :profile

  def create_notifications_for_user_that_have_comments(post, profile_that_made_comment_id)
    message = "A User has commented on a post."
    n_type = 0
    resource = "/posts/" + post.id
    post.comment.each do |c|
      n = Notification.new(c.profile.id, message, n_type, resource).save! if profile_that_made_comment_id != c.profile.id
    end
  end
end
