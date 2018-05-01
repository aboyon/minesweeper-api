require 'rails_helper'

describe GamesController, :type => :controller do
  render_views
  authenticate_user

  describe "#POST create" do
    let(:game_params) { attributes_for(:game) }

    before { post :create, {:params => {:game => game_params} } }

    it { expect(response).to be_success }
    it { expect(json_response[:user_id]).to eq(subject.current_user.id) }
  end

  describe "#GET" do

    context "/index" do
      before { get :index }
      
      it {  }
    end
  end

end