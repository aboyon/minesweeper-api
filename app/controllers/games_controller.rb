class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.for_user(current_user)
    render :index, :status => :ok, :formats => :json
  end

  def show
    @game = Game.find(params[:id])
    render :show, :status => :ok, :formats => :json
  rescue ActiveRecord::RecordNotFound => e
    head :not_found
  end

  def create
    @game = Game.create!(create_params)
    render :create, :status => :created, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  private

    def create_params
      params.require(:game)
        .permit(:rows, :cols, :bombs).merge!(:user_id => current_user.id)
    end
end