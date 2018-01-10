class PostsController < ApplicationController
  #before_action :authenticate_user!
  before_action :find_posts, only: [:index]
  before_action :find_post, only: [:show]
  before_action :create_post, only: [:create]
  before_action :find_and_update_post, only: [:update]

  def index
    raise ActiveRecord::RecordNotFound, "No post found" if @posts.empty?
    render json: @posts, status: 200
  end

  def show
    raise ActiveRecord::RecordNotFound, "No post found" if @post.nil?
    render json: @post, status: 200
  end

  def create
    render json: @post, status: 201
  end

  def update
    raise ActiveRecord::RecordNotFound, "No post found" if @post.empty?
    render json: @post, status: 200
  end 

  private

  def find_post
    @post = Post.find(params[:id]).includes(:comment, :like)
  end

  def find_posts
    @posts = Post.includes(:comment, :like).order(created_at: :desc).limit(params[:size])
  end

  def find_and_update_post
    @post = Post.find(params[:id])
    @post.update_attributes!(p_params)
  end

  def create_post
    @post = Post.new(p_params)
    current_user.profile.post << @post
    @post.save!
  end

  def p_params
      params.require(:post).permit(:user_id,
                                   :text)
  end
end
