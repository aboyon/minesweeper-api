class UsersController < ApplicationController
  def create
    @current_user = User.create!(create_parameters)
    render :create, :status => :ok, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  private

    def create_parameters
      params.require(:user)
        .permit(:email, :name, :password)
    end
end
