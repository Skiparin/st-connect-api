class UserSearchesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_result_with_simple_search, only: [:index]
	before_action :check_if_skill_is_array, only: [:create]
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
			query_string = ""
			params[:filter].each do |filter, value|
				sql_string << add_table_to_sql_string(filter, value, sql_string)
				if filter == "skill"
					value.each do |skill_value|
						query_string << make_sql_query(filter, skill_value.to_s)
					end
				else	
					query_string << make_sql_query(filter, value)
				end
			end
			sql_string << " WHERE "
			string = sql_string << query_string
			@results = Profile.includes(:skill, :education, :experience).find_by_sql(string)
		end

		def get_result_with_simple_search
			@result = Profile.where("#{params[:filter]} like '%#{params[:value]}%'")
		end

		# Create the condition part of the query, based on the content of the search.
		def make_sql_query(filter, value)
			string = ""
			case filter
			when "name"
				string << "profiles.name like '%#{value}%' AND "
			when "email"
				string << "contact_infos.email like '%#{value}%' AND "
			when "skill"
				string << "skills.name like '%#{value}%' AND "
			when "experience"
				string << "experiences.title like '%#{value}%' AND "
			when "education"
				string << "educations.degree like '%#{value}%' AND "
			end

			Thread.new do
  			create_or_update_search_statistic(filter, value)
  			ActiveRecord::Base.connection.close
			end
			# Removes the last "AND ".
			string[0..-5]
		end

		# Create or update the search_statistics belonging to the current search.
		def create_or_update_search_statistic(filter, value)
			job_desc = get_job_description
			search_statistic = SearchStatistic.where("search_string = ? and target = ?", value, filter).first
			if search_statistic.nil?
				job_desc_hash = {}
				job_desc_hash[job_desc] = 1
				SearchStatistic.new(search_string: value, 
													 	target: filter, 
													 	job_descriptions_using_search: job_desc_hash).save! 
			else
				search_statistic.job_descriptions_using_search[job_desc] = 1 + search_statistic.job_descriptions_using_search[job_desc.to_sym].to_i
				search_statistic.number_of_searches += 1
				search_statistic.save!
			end
		end

		# Return a error if the skill value isn't an Array.
		def check_if_skill_is_array
    	raise ArgumentError.new("Skill param needs to be an array.") if !(params[:filter][:skill].is_a?(Array)) && !params[:filter][:skill].nil?
		end

		# Return current_user's current or latest job title.
		# Returns 'Unemployed' if there aren't any experiences.
		def get_job_description
			return "Unemployed".to_sym if current_user.profile.experience.empty?
			current_user.profile.experience.each do |e|
				return e.title.to_sym if e.is_still_working
			end
			current_user.experience.order(end_time: :desc).first.title
		end

		# Add which tabels the query should query from.
		def add_table_to_sql_string(filter, value, sql_string)
			string = ""
			string = "SELECT profiles.* FROM profiles" if sql_string.empty?
			if ["skill"].include? filter
				string << ", skills" 
			elsif ["experience"].include? filter
				string << ", experiences"
			elsif ["education"].include? filter
				string << ", educations" 
			elsif ["email"].include? filter
				string << ", contact_infos" 
			end
			return string
		end
end
