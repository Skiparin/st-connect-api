class UserSearchesController < ApplicationController
	#before_action :authenticate_user!
	before_action :get_result_with_simple_search, only: [:index]
	before_action :check_if_skill_is_array, only: [:create]
	before_action :get_result, only: [:create]

	def index
		raise ActiveRecord::RecordNotFound, "No users found" if @result.empty?
    render json: @result, status: 200
	end

	def create
		request.headers.each do |key, value| 
			print key.to_s + " : " + value.to_s + "/n"
		end
		raise ActiveRecord::RecordNotFound, "No users found" if @results.empty?
		render json: @results, status: 201
	end

	private
		def get_result
			sql_string = ""
			params[:filter].each do |filter, value|
				if filter == "skill"
					value.each do |skill_value|
						sql_string << make_sql_query(filter, skill_value.to_s)
					end
				else	
					sql_string << make_sql_query(filter, value)
				end
			end

			@results = Profile.includes(:skill, :education, :experience).find_by_sql(sql_string)
		end

		def get_result_with_simple_search
			@result = Profile.where("#{params[:filter]} like '%#{params[:value]}%'")
		end

		def make_sql_query(filter, value)
			string = "SELECT profiles.* FROM profiles"
			string << ", skills" if ["skill"].include? filter
			string << ", experiences" if ["experience"].include? filter
			string << ", educations" if ["education"].include? filter
			string << " WHERE "
			case filter
			when "name"
				string << "profiles.name like '%#{value}%' AND "
			when "email"
				string << "profiles.email like '%#{value}%' AND "
			when "skill"
				string << "skills.name like '%#{value}%' AND "
			when "experience"
				string << "experiences.degree like '%#{value}%' AND "
			when "education"
				string << "educations.title like '%#{value}%' AND "
			end

			Thread.new do
  				create_search_statistic(filter, value)
  				ActiveRecord::Base.connection.close
			end

			string[0..-5]
		end

		def create_search_statistic(filter, value)
			job_desc = get_job_description
			search_statistic = SearchStatistic.where("search_string = ? and target = ?", value, filter).first
			print "*************************" + search_statistic.to_s
			if search_statistic.nil?
				SearchStatistic.new(search_string: value, 
													 	target: filter, 
													 	job_descriptions_using_search: {job_desc: 1}).save! 

			else
				search_statistic.job_descriptions_using_search[job_desc] = 1 + search_statistic.job_descriptions_using_search[job_desc.to_sym].to_i
				search_statistic.number_of_searches += 1
				search_statistic.save!
			end
		end

		def check_if_skill_is_array
    	raise ArgumentError.new("Skill param needs to be an array.") if !(params[:filter][:skill].is_a?(Array)) && !params[:filter][:skill].nil?
		end

		def get_job_description
			return "Unemployed".to_sym if current_user.profile.experience.empty?
			current_user.profile.experience.each do |e|
				return e.title.to_sym if e.is_still_working
			end
			current_user.experience.order(end_time: :desc).first.title
		end
end
