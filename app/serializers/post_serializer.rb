class PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :profile_id, :number_of_likes, :created_at, :updated_at

  has_many :like
  has_many :comment

  class LikeSerializer < ActiveModel::Serializer
	  attributes :profile_id
	end

	class CommentSerializer < ActiveModel::Serializer
	  attributes :text, :profile_id, :created_at, :updated_at
	end
end
