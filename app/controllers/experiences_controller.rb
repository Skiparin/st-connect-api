class ExperiencesController < ApiController
	before_action :authenticate_user!
	before_action :authenticate_user_id_equals_current_user
	before_action :create_experience, only: [:create]
	before_action :find_and_update_experience, only: [:update]

	def create
		render json: @experience, status: 201
	end

	def update
    raise ActiveRecord::RecordNotFound, "No experience found" if @experience.empty?
		render json: @experience, status: 200
	end 

	private

	def find_and_update_experience
		@experience = Experience.find(params[:id])
		@experience.update_attributes!(e_params)
	end

	def create_experience
		@experience = Experience.new(e_params)
		current_user.profile.experience << @experience
		@experience.save!
	end

	def e_params
      params.require(:experience).permit(:title,
                                         :company,
                                         :location,
                                         :start_time,
                                         :end_time,
                                         :is_still_working,
                                         :description)
	end
end
