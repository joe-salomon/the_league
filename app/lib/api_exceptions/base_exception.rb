# create custom error codes and messages for child error classes
module ApiExceptions  
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new {|code, message| {status: "error", code: code, message: message}}
    ERROR_CODE_MAP = {
      "RequestError::InvalidYearError" =>
        ERROR_DESCRIPTION.call(3000, "This is not a valid year for this league."),
      "RequestError::InvalidLeagueError" =>
        ERROR_DESCRIPTION.call(3001, "This is not a valid league_id."),
      "RequestError::PrivateLeagueError" =>
        ERROR_DESCRIPTION.call(4000, "This is league is private.")
    }

    def initialize
      error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
      ApiExceptions::BaseException::ERROR_CODE_MAP
        .fetch(error_type, {}).each do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end  
