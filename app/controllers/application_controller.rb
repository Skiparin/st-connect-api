class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  before_filter :set_default_response_format

private
  def set_default_response_format
    request.format = :json
  end
end
