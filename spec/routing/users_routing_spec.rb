require 'rails_helper'

describe "Routes for User", :type => :routing do
  it "POST /users" do
    expect(:post => "/users.json").to route_to(
      :controller => "users",
      :action => "create",
      :format => 'json'
    )
  end

  it "GET /users/:id" do
    expect(:get => "/users/1.json").to route_to(
      :controller => "users",
      :action => "show",
      :id => '1',
      :format => 'json'
    )
  end
end