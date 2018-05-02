require 'rails_helper'

describe Game do
  describe "#create" do

    context "validations" do
      it "user can't be blank" do
        expect {
          create(:game, :user_id => nil)
        }.to raise_error(ActiveRecord::RecordInvalid, /User must exist/)
      end

      it "bombs can't be blank" do
        expect {
          create(:game, :bombs => nil)
        }.to raise_error(ActiveRecord::RecordInvalid, /Bombs can't be blank/)
      end

      it "Bombs must be greater than" do
        expect {
          create(:game, :bombs => 0)
        }.to raise_error(ActiveRecord::RecordInvalid, /Bombs must be greater than/)
      end
    end

    context "valid user" do
      it { expect(create(:game)).to be_a(Game) }
    end

    context 'dimension' do
      let(:game) { create(:game) }
      it { expect(game.squares).to all(be_a(Square)) }
      it { expect(game.squares.size).to eq(25) }

      it "planted bombs match with user prefs" do
        planted_bombs = game.squares.select(&:bomb?).size
        expect(game.bombs).to eq(planted_bombs)
      end

      context '[3x3] - Contiguous to 1,1 with bomb in 0,0' do
        # B - -
        # - S -
        # - - -
        let(:game) { create(:game, :rows => 3, :cols => 3, :bombs => 1) }
        let(:square) { game.coords(1,1) }
        let(:contiguous) { square.contiguous }

        before do
          # we have to force the bomb to be in a corner
          game.squares.update_all(:bomb => false)
          game.coords(0,0).become_a_bomb!
        end

        it { expect(contiguous).not_to be_empty }
        it { expect(contiguous).to all(be_a(Square)) }

        it "0,0 isn't contiguous of 1,1 (because is the bomb)" do
          expect(contiguous).not_to have_square_in(0,0)
        end

        it "0,1 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(0,1)
        end

        it "0,2 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(0,2)
        end

        it "1,0 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(1,0)
        end

        it "1,2 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(1,2)
        end

        it "2,0 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(2,0)
        end

        it "2,1 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(2,1)
        end

        it "2,2 it's contiguous of 1,1" do
          expect(contiguous).to have_square_in(2,2)
        end
      end

      context '[3x3] - Contiguous to 0,0 with bomb in 2,2' do
        # S - -
        # - - -
        # - - B
        let(:game) { create(:game, :rows => 3, :cols => 3, :bombs => 1) }
        let(:square) { game.coords(0,0) }
        let(:contiguous) { square.contiguous }

        before do
          # we have to force the bomb to be in a corner
          game.squares.update_all(:bomb => false)
          game.coords(2,2).become_a_bomb!
        end

        it { expect(contiguous).not_to be_empty }
        it { expect(contiguous).to all(be_a(Square)) }

        it "0,2 isn't contiguous of 0,0" do
          expect(contiguous).not_to have_square_in(0,2)
        end

        it "0,1 it's contiguous of 0,0" do
          expect(contiguous).to have_square_in(0,1)
        end

        it "1,2 isn't contiguous of 0,0" do
          expect(contiguous).not_to have_square_in(1,2)
        end

        it "1,1 it's contiguous of 0,0" do
          expect(contiguous).to have_square_in(1,1)
        end

        it "1,0 it's contiguous of 1,0" do
          expect(contiguous).to have_square_in(1,0)
        end

        it "2,0 isn't contiguous of 0,0" do
          expect(contiguous).not_to have_square_in(2,0)
        end

        it "2,1 isn't contiguous of 0,0" do
          expect(contiguous).not_to have_square_in(2,1)
        end
      end

      context '[4x4] - Contiguous to 0,0 with bomb in 1,1 and 0,1' do
        # S B - -
        # - B - -
        # - - S -
        # S - - -
        let(:game) { create(:game, :rows => 4, :cols => 4, :bombs => 2) }
        let(:square) { game.coords(0,0) }

        before(:each) do
          game.squares.update_all(:bomb => false, :bombs => 0)
          # we have to force the bomb in these places
          game.coords(0,1).become_a_bomb!
          game.coords(1,1).become_a_bomb!
          game.squares.reload
        end

        it "Square in 0,0 has two bombs near" do
          square.reload
          expect(square.bombs).to eq(2)
        end

        it "Square in 0,3 has not bombs near" do
          square_0_3 = game.coords(0,3)
          expect(square_0_3.reload.bombs).to eq(0)
        end

        it "Square in 2,2 has one bombs near" do
          square_2_2 = game.coords(2,2)
          expect(square_2_2.reload.bombs).to eq(1)
        end
      end

      context '[4x4] - Contiguous to 0,0 with bomb in 1,1; 0,1; 0,3 and 3,3' do
        # S B S B
        # - B - -
        # - - S -
        # S - - B
        let(:game) { create(:game, :rows => 4, :cols => 4, :bombs => 4) }
        let(:square) { game.coords(0,0) }

        before(:each) do
          game.squares.update_all(:bomb => false, :bombs => 0)
          # we have to force the bomb in these places
          game.coords(0,1).become_a_bomb!
          game.coords(1,1).become_a_bomb!
          game.coords(0,3).become_a_bomb!
          game.coords(3,3).become_a_bomb!
          game.squares.reload
        end

        it "Square in 0,0 has two bombs near" do
          square.reload
          expect(square.bombs).to eq(2)
        end

        it "Square in 2,2 has 2 bombs near" do
          square_2_2 = game.coords(2,2)
          expect(square_2_2.reload.bombs).to eq(2)
        end

        it "Square in 0,2 has 3 bombs near" do
          square_0_2 = game.coords(0,2)
          expect(square_0_2.reload.bombs).to eq(3)
        end
      end

      context '[4x4] - reveal action on 0,0 and 3,3' do
        # S * - B
        # * * B -
        # - B * *
        # B - * S
        let(:game) { create(:game, :rows => 4, :cols => 4, :bombs => 4) }

        before(:each) do
          game.squares.update_all(:bomb => false, :bombs => 0)
          # we have to force the bomb in these places
          game.coords(0,3).become_a_bomb!
          game.coords(2,1).become_a_bomb!
          game.coords(1,2).become_a_bomb!
          game.coords(3,0).become_a_bomb!
          game.squares.reload
        end

        it "reveal 0,0 expands [(0,1),(1,0),(1,1)]" do
          square = game.coords(0,0)
          square.reload
          revealed = square.reveal!
          expect(revealed.size).to eq(4)
        end

        it "reveal 3,3 expands [(2,3),(3,2),(2,2)]" do
          square = game.coords(3,3)
          square.reload
          revealed = square.reveal!
          expect(revealed.size).to eq(4)
        end

        it "reveal 3,1 expands []" do
          # S * - B
          # * * B S
          # - B * *
          # B - * S
          square = game.coords(3,1)
          square.reload
          revealed = square.reveal!
          expect(revealed.size).to eq(1)
        end
      end

      context '[4x4] - reveal the bomb.' do
        # S - - B
        # - - ! -
        # - B - -
        # B - - S
        let(:game) { create(:game, :rows => 4, :cols => 4, :bombs => 2) }

        before(:each) do
          game.squares.update_all(:bomb => false, :bombs => 0)
          # we have to force the bomb in these places
          game.coords(0,3).become_a_bomb!
          game.coords(2,1).become_a_bomb!
          game.coords(1,2).become_a_bomb!
          game.coords(3,0).become_a_bomb!
          game.squares.reload
        end

        it "reveal 2,1 ends the game" do
          square = game.coords(2,1)
          square.reveal!
          game.reload
          expect(game).to be_over
        end

      end
    end

  end
end