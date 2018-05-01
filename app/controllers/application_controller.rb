class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_user

  def authenticate_user!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(:session_token => token)
    end
  end
end
