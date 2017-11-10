class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  Unauthorized = Class.new(StandardError)

  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
	rescue_from ApiController::Unauthorized, with: :render_unauthorized
end