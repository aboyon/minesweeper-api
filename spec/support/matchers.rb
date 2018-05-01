RSpec::Matchers.define :be_user_game do |user|
  match do |code_desc|
    match_class = be_a(Game)
    match_user  = eql(user)
    match_class && match_user
  end
end