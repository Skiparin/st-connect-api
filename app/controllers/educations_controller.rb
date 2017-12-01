class EducationsController < ApiController
	before_action :authenticate_user!
	before_action :authenticate_user_id_equals_current_user
	before_action :create_education, only: [:create]
	before_action :find_and_update_education, only: [:update]

	def create
		render json: @education, status: 201
	end

	def update
    raise ActiveRecord::RecordNotFound, "No eeducation found" if @education.empty?
		render json: @education, status: 200
	end 

	private

	def find_and_update_education
		@education = Education.find(params[:id])
		@education.update_attributes!(e_params)
	end

	def create_education
		@education = Education.new(e_params)
		current_user.education << @education
		@education.save!
	end

	def e_params
      params.require(:education).permit( :degree,
                                         :school,
                                         :field_of_study
                                         :location,
                                         :start_time,
                                         :end_time,
                                         :is_still_studying,
                                         :description)
	end
end
