class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :experience
  has_many :education
  has_many :skill
  has_many :contact_info

	class ExperienceSerializer < ActiveModel::Serializer
 		attributes :id, :title, :company, :location, :start_time,
 							 :end_time, :is_still_working, :description
	end

	class EducationSerializer < ActiveModel::Serializer
 		attributes :id, :degree, :school, :location, :field_of_study,
 							 :start_time, :end_time, :is_still_studying, :description
	end

	class SkillSerializer < ActiveModel::Serializer
 		attributes :id, :name, :description
	end

	class ContactInfoSerializer < ActiveModel::Serializer
 		attributes :id, :email, :phone, :address
	end
end