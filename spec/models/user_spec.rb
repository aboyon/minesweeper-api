require 'rails_helper'

describe User do
  describe "#create" do

    context "validations" do
      it "name can't be blank" do
        expect {
          create(:user, :name => '')
        }.to raise_error(ActiveRecord::RecordInvalid, /Name can't be blank/)
      end

      it "Email can't be blank" do
        expect {
          create(:user, :email => '')
        }.to raise_error(ActiveRecord::RecordInvalid, /Email can't be blank/)
      end

      it "Password can't be blank" do
        expect {
          create(:user, :password => '')
        }.to raise_error(ActiveRecord::RecordInvalid, /Password can't be blank/)
      end

      it "Passwords doesn't match" do
        expect {
          create(:user, :password => 'ABC', :password_confirmation => 'asdasd')
        }.to raise_error(ActiveRecord::RecordInvalid, /Password confirmation doesn't match/)
      end

      it "Email can't be blank" do
        user = create(:user)
        expect {
          create(:user, :email => user.email)
        }.to raise_error(ActiveRecord::RecordInvalid, /Email has already been taken/)
      end
    end

    context "valid user" do
      it { expect(create(:user)).to be_a(User) }
    end

  end
end
