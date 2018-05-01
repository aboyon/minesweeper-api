require 'rails_helper'

describe GamesController, :type => :controller do
  render_views
  authenticate_user

  before { @request.env['HTTP_ACCEPT'] = "application/json" }

  describe "#POST create" do
    let(:game_params) { attributes_for(:game) }

    before { post :create, {:params => {:game => game_params} } }

    it { expect(response).to be_success }
    it { expect(json_response[:user_id]).to eq(subject.current_user.id) }
  end

  describe "#GET" do
    let!(:games) do
      create_list(:game, 5, :user => subject.current_user)
    end

    describe "/index" do
      before do
        get :index
      end
      
      it { expect(assigns(:games)).not_to be_empty  }
      it { expect(assigns(:games)).to all(be_user_game(subject.current_user))  }
    end

    describe "/show/:id" do
      before do
        get :show, {:params => {:id => game_id} }
      end
      context "HTTP 200" do
        let(:game_id) { games.first.id }
        it { expect(response).to be_success }
        it { expect(assigns(:game)).to be_user_game(subject.current_user) }
      end
      context "HTTP 404" do
        let(:game_id) { 99999 }
        it { expect(response.code.to_i).to eq(404) }
      end
    end
  end

end