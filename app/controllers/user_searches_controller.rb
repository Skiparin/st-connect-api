class UserSearchesController < ApplicationController
	before_action :get_result_with_simple_search, only: [:index]
	before_action :get_result, only: [:create]

	def index
		raise ActiveRecord::RecordNotFound, "No users found" if @result.empty?
    render json: @result, status: 200
	end

	def create
		raise ActiveRecord::RecordNotFound, "No users found" if @results.empty?
		render json: @results, status: 201
	end

	private
		def get_result
			sql_string = ""
			params[:filter].each do |f, v|
				sql_string << make_sql_query(f,v)
			end

			@results = Profile.includes(:skill, :experience, :education).where(sql_string[0..-4])
		end

		def get_result_with_simple_search
			@result = Profile.where("#{params[:filter]} like '%#{params[:value]}%'")
		end

		def make_sql_query(filter, value)
			string = ""
			case filter
			when "name"
				string = "profiles.name like '%#{value}%' AND"
			when "email"
				string = "#{filter} like '%#{value}%' AND"
			when "skill"
				string = "skills.name like '%#{value}%' AND"
			when "experience"
				string = "experiences.degree like '%#{value}%' AND"
			when "education"
				string = "educations.title like '%#{value}%' AND"
			end
			Thread.new do
  			create_search_statistic(filter, value)
  			ActiveRecord::Base.connection.close
			end
			
			string
		end

		def create_search_statistic(filter, value)
			job_desc = "datamatikerr" 
			search_statistic = SearchStatistic.where("search_string = ? and target = ?", value, filter).first
			if search_statistic.nil?
				SearchStatistic.new(search_string: value, 
													 	target: filter, 
													 	job_descriptions_using_search: {job_desc: 1}).save! 

			else
				search_statistic.job_descriptions_using_search[job_desc.to_sym] = 1 + search_statistic.job_descriptions_using_search[job_desc.to_sym].to_i
				search_statistic.number_of_searches += 1
				search_statistic.save!
			end
		end
end
