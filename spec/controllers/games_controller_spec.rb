require 'rails_helper'

describe GamesController, :type => :controller do
  render_views
  authenticate_user
  ensure_request_headers

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

  describe "#PUT" do
    let!(:game) do
      create(:game, :user => subject.current_user, :bombs => 1)
    end

    describe "/games/:id/reveal/1/1" do
      before do
        game.squares.update_all(:bomb => false, :bombs => 0)
        # we have to force the bomb in these places
        game.coords(4,4).become_a_bomb!
        game.squares.reload
        put :reveal, {:params => {:id => game.id, :x => 1, :y => 1} }
      end

      it "square at 0,0 it's revealed" do
        json_square = json_response[:squares].find do |square|
          square[:x] == 0 && square[:y] == 0
        end
        square = game.coords(0,0)
        expect(json_square['revealed']).to eq(square.revealed?)
      end

      it "square at 1,1 it's revealed" do
        json_square = json_response[:squares].find do |square|
          square[:x] == 1 && square[:y] == 1
        end
        square = game.coords(1,1)
        expect(json_square['revealed']).to eq(square.revealed?)
      end

      it "square at 3,3 it's revealed" do
        json_square = json_response[:squares].find do |square|
          square[:x] == 3 && square[:y] == 3
        end
        square = game.coords(3,3)
        expect(json_square['revealed']).to eq(square.revealed?)
      end
    end
  end

end