require 'rails_helper'

describe "Routes for Sessions", :type => :routing do
  it "POST /sessions" do
    expect(:post => "/sessions.json").to route_to(
      :controller => "sessions",
      :action => "create",
      :format => 'json'
    )
  end
end