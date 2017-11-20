class UserSearchesController < ApplicationController
	before_action :get_result_with_simple_search, only: [:index]
	before_action :get_result, only: [:create]

	def index
		raise ActiveRecord::RecordNotFound, "No users found" if @result.empty?
    render json: @result, status: 200
	end

	def create
		raise ActiveRecord::RecordNotFound, "No users found" if @results.empty?
		render json: @results, status: 200
	end

	private
		def get_result
			sql_string = ""
			params[:filter].each do |f, v|
				sql_string << make_sql_query(f,v)
			end

		@results = Profile.joins(:skill, :experience, :education).where(sql_string[0..-4])
		end

		def get_result_with_simple_search
			@result = Profile.where("#{params[:filter]} like '%#{params[:value]}%'")
		end

		def make_sql_query(filter, value)
			case filter
			when "name"
				"#{filter} like '%#{value}%' AND"
			when "nickname"
				"#{filter} like '%#{value}%' AND"
			when "email"
				"#{filter} like '%#{value}%' AND"
			when "skill"
				"skills.name like '%#{value}%' AND"
			when "experience"
				"experiences.degree like '%#{value}%' AND"
			when "education"
				"educations.title like '%#{value}%' AND"
			end
		end
end
