class ProfilesController < ApiController
	before_action :authenticate_user!
	before_action :find_profile, only: [:show]

	def show
    	render json: @profile, status: 200
	end

	private
		def find_profile
			@profile = Profile.find(params[:id])
		end

end
