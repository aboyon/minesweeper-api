class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index, :status => :success, :formats => :json
  end

  def create
    @game = Game.create!(:user => current_user)
    render :create, :status => :created, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end
end