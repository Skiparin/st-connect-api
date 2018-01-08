class CommentController < ApiController
  before_action :authenticate_user!
  before_action :create_comment, only: [:create]
  before_action :find_and_update_comment, only: [:update]

  def create
    render json: @comment, status: 201
  end

  def update
    raise ActiveRecord::RecordNotFound, "No comment found" if @comment.empty?
    render json: @comment, status: 200
  end 

  private
  def find_and_update_comment
    @comment = Comment.find(params[:id])
    @comment.update_attributes!(c_params)
  end

  def create_comment
    @comment = Comment.new(c_params)
    Post.find(c_params[:post_id]).comment << @comment
    @comment.save!
  end

  def c_params
      params.require(:comment).permit(:user_id,
                                      :post_id,
                                      :text)
  end
end
