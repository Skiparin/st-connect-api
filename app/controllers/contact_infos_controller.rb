class ContactInfosController < ApplicationController
	before_action :authenticate_user!
	before_action :create_contact_info, only: [:create]
	before_action :find_and_update_contact_info, only: [:update]

	def create
		render json: @contact_info, status: 201
	end

	def update
    raise ActiveRecord::RecordNotFound, "No contact info found" if @contact_info.empty?
		render json: @contact_info, status: 200
	end 

	private

	def find_and_update_contact_info
		@contact_info = ContactInfo.find(params[:id])
		@contact_info.update_attributes!(e_params)
	end

	def create_contact_info
		@contact_info = ContactInfo.new(e_params)
		current_user.contact_info << @contact_info
		@contact_info.save!
	end

	def e_params
      params.require(:contact_info).permit( :profile_id,
      																			:email,
      																			:phone,
      																			:address,
      																			:date_of_birth )
	end
end
