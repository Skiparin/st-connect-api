class LikeController < ApiController
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
    @like = Like.new(l_params)
    User.first.like << @like
    @like.save!
  end

  def l_params
      params.require(:like).permit(:user_id,
                                   :post_id)
  end
end
