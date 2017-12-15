class SkillsController < ApiController
	before_action :authenticate_user!
	before_action :create_skill, only: [:create]
	before_action :find_and_update_skill, only: [:update]

	def create
		render json: @skill, status: 201
	end

	def update
		raise ActiveRecord::RecordNotFound, "No skill found" if @skill.empty?
		render json: @skill, status: 200
	end 

	private

	def find_and_update_skill
		@skill = Skill.find(params[:id])
		@skill.update_attributes!(s_params)
	end

	
	def create_skill
		@skill = Skill.where("name = ?", s_params[:name]).first
		@skill = Skill.new(s_params) if @skill.nil?
		current_user.profile.skill << @skill unless @skill.profile.include?(current_user.profile) 
		@skill.save!
	end

	def s_params
      params.require(:skill).permit(:name,
                                    :description)
	end
end
