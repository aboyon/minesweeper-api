json.(@game, :id, :user_id)
json.over @game.over?
json.squares do
  json.array! @game.squares do |square|
    json.x square.x
    json.y square.y
    json.revealed square.revealed?
  end
end