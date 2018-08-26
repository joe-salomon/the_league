module ApiExceptions  
  class RequestError < ApiExceptions::BaseException
    class InvalidYearError < ApiExceptions::RequestError
    end
  end
end  