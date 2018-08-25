class ApplicationController < ActionController::Base
  # include ExceptionHandler
  # include Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    json_response({ message: e.message }, :unprocessable_entity)
  end
end
