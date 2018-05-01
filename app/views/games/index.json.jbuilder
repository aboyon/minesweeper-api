json.array! @games do |game|
  json.user_id game.user_id
  json.terminated game.terminated?
end