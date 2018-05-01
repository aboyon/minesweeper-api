class SessionsController < ApplicationController
  def create
    if @current_user = User.authenticate(session_params[:email], session_params[:password])
      render :create, :status => :accepted, :formats => :json
    else
      render :json => {'error' => 'User not found'}, :status => :not_found
    end
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
