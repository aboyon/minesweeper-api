class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_game, :only => [:show, :reveal]

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def index
    @games = current_user.games
    render :index, :status => :ok, :formats => :json
  end

  def show
    render :show, :status => :ok, :formats => :json
  end

  def create
    @game = current_user.games.create!(create_params)
    render :create, :status => :created, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  def reveal
    square = @game.coords(play_params[:x], play_params[:y])
    square.reveal!
    render :show, :status => :ok, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  private

    def load_game
      @game = current_user.games.find(params[:id])
    end

    def create_params
      params.require(:game).permit(:rows, :cols, :bombs)
    end

    def play_params
      params.permit(:x, :y)
    end
end