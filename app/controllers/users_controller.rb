class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
    render json: User.find(params[:id]), status: 200
	end
end
