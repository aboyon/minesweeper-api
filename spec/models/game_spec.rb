require 'rails_helper'

describe Game do
  describe "#create" do

    context "validations" do
      it "user can't be blank" do
        expect {
          create(:game, :user_id => nil)
        }.to raise_error(ActiveRecord::RecordInvalid, /User must exist/)
      end
    end

    context "valid user" do
      it { expect(create(:game)).to be_a(Game) }
    end

  end
end