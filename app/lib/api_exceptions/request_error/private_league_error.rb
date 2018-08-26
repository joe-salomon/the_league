module ApiExceptions  
  class RequestError < ApiExceptions::BaseException
    class PrivateLeagueError < ApiExceptions::RequestError
    end
  end
end  