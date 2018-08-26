class ApplicationController < ActionController::Base
  # include ExceptionHandler
  # include Response
  def json_response(object,  message = nil)
      render json: object
  end
  
  rescue_from ApiExceptions::BaseException, 
    :with => :render_error_response 
     
  rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    json_response({ message: e.message }, :unprocessable_entity)
  end
  
  def render_error_response(error)
    render json: error, serializer: ApiExceptionSerializer, status: 200
  end
  
end
