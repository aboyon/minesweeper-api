require 'rails_helper'

describe "Routes for Games", :type => :routing do
  it "GET /games" do
    expect(:get => "/games.json").to route_to(
      :controller => "games",
      :action => "index",
      :format => 'json'
    )
  end

  it "POST /games" do
    expect(:post => "/games.json").to route_to(
      :controller => "games",
      :action => "create",
      :format => 'json'
    )
  end

  it "GET /games/:id" do
    expect(:get => "/games/1.json").to route_to(
      :controller => "games",
      :action => "show",
      :id => '1',
      :format => 'json'
    )
  end
end