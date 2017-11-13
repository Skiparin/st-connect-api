class PostController < ApplicationController
  before_action :create_post, only: [:create]
  before_action :find_and_update_post, only: [:update]

  def create
    render json: @post, status: 201
  end

  def update
    raise ActiveRecord::RecordNotFound, "No post found" if @post.empty?
    render json: @post, status: 200
  end 

  private

  def find_and_update_post
    @post = Post.find(params[:id])
    @post.update_attributes!(p_params)
  end

  def create_post
    @post = Post.new(p_params)
    User.first.post << @post
    @post.save!
  end

  def p_params
      params.require(:post).permit(:user_id,
                                   :text)
  end
end
