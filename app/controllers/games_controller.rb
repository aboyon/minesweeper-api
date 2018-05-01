class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
    render :index, :status => :ok, :formats => :json
  end

  def show
    @game = current_user.games.find(params[:id])
    render :show, :status => :ok, :formats => :json
  rescue ActiveRecord::RecordNotFound => e
    head :not_found
  end

  def create
    @game = current_user.games.create!(create_params)
    render :create, :status => :created, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  private

    def create_params
      params.require(:game)
        .permit(:rows, :cols, :bombs)
    end
end