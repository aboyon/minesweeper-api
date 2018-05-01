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
    end

  end
end