RSpec::Matchers.define :be_user_game do |user|
  match do
    match_class = be_a(Game)
    match_user  = eql(user)
    match_class && match_user
  end
end

RSpec::Matchers.define :have_square_in do |x,y|
  match do |contiguous|
    square = contiguous.find_by(:x => x, :y => y)
    return false unless square
    match_class = square.kind_of?(Square)
    match_x = square.x.eql?(x)
    match_y = square.y.eql?(y)

    match_class && match_x && match_y
  end
end