require 'rails_helper'

describe UsersController, :type => :controller do
  render_views
  ensure_request_headers

  describe "#POST create" do
    let(:user_params) { attributes_for(:user) }

    before { post :create, {:params => {:user => user_params} } }

    it { expect(response).to be_success }
    it { expect(json_response[:name]).to eq(user_params[:name]) }
    it { expect(json_response[:email]).to eq(user_params[:email]) }
    it { expect(json_response[:session_token]).not_to be_empty }
  end

end