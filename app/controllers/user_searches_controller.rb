class UserSearchesController < ApplicationController
	before_action :get_result

	def index
    render json: @result, status: 200
	end

	private
		def get_result
			@result = User.where("#{params[:filter]} like '%#{params[:value]}%'")
		end
end
