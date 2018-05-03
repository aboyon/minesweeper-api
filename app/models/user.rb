class User < ApplicationRecord
  has_secure_password

  has_many :games
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  before_create :set_session_token

  def self.authenticate(email, password)
    user = self.find_by(:email => email)
    if user&.authenticate(password)
      user.set_session_token
      user.save
      return user
    end
    false
  end

  def set_session_token
    self.session_token = Digest::SHA1.hexdigest([Time.now, rand, id].join)
  end

end