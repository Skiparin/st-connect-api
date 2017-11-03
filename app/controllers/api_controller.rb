class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

before_action :set_default_response_format

private
  def set_default_response_format
    request.format = :json
  end
end