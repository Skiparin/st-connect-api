class UsersController < ApplicationController
	#before_action :authenticate_user!
	#before_action :authenticate_user_id_equals_current_user 

	def show
    render json: current_user, status: 200
	end
end