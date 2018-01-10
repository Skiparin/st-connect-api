class LikesController < ApiController
  before_action :authenticate_user!
  before_action :create_like, only: [:create]
  before_action :find_and_update_like, only: [:update]

  def create
    render json: @like, status: 201
  end

  def update
    raise ActiveRecord::RecordNotFound, "No like found" if @like.empty?
    render json: @like, status: 200
  end 

  private

  def find_and_update_like
    @like = Like.find(params[:id])
    @like.update_attributes!(l_params)
  end

  def create_like
    @like = Like.where("post_id = ? AND profile_id = ?", l_params[:post_id], current_user.profile.id).first
    if !@like
      @like = Like.new(post_id: l_params[:post_id], profile_id: current_user.profile.id)
      Post.find(l_params[:post_id]).like << @like
      @like.save!
    end
  end

  def l_params
      params.require(:like).permit(:user_id,
                                   :post_id)
  end
end
