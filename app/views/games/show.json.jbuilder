json.(@game, :id, :user_id, :rows, :cols, :bombs)
json.over @game.over?
json.terminated @game.terminated?
json.squares do
  json.array! @game.squares do |square|
    json.x square.x
    json.y square.y
    json.revealed square.revealed?
    json.bombs square.bombs
    json.is_bomb square.bomb?
  end
end