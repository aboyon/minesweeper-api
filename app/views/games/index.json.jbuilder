json.array! @games do |game|
  json.(game, :id, :user_id, :rows, :cols, :bombs)
  json.over game.over?
  json.terminated game.terminated?
end