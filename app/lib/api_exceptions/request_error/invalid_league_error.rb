module ApiExceptions  
  class RequestError < ApiExceptions::BaseException
    class InvalidLeagueError < ApiExceptions::RequestError
    end
  end
end  