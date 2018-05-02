# Minesweeper

## Summary

This API provides game status persistence for the classic minesweeper game. Code incorporates the logic to build up the game's grid, performs validations, and terminate the game as soon as a bomb it's clicked. Each game belongs to an already registered user. 

This code exposes API endpoints for each operation: 
- Sign up
- Sign In users
- Create/Play games
- explore grid by evaluating the contiguous square in game's matrix.
- Set of unit specs with common cases

## Install / Setting up

If you're using docker, remember to build the image and run all the rails/rake command through docker-compose (e.g `docker-compose run api bundle exec rspec spec`).

## Clone the repo

```
git clone git@github.com:aboyon/minesweeper-api.git
```

## Classic way - Using rbenv and your host as execution content

```
rbenv install 2.4.1
gem install bundler
bundle install
bundle exec rake db:create db:migrate
bundle exec rake db:create db:migrate RAILS_ENV=test
bundle exec rails s -p 3000 -b 0.0.0.0
# or
bundle exec rspec spec/
```

Then, try [http://localhost:3000/](http://localhost:3000/)

## With Docker - using a container
```
docker-compose build
docker-compose run api bundle exec rake db:create db:migrate
docker-compose run api bundle exec rake db:create db:migrate RAILS_ENV=test
docker-compose up
# or
bundle exec rspec spec/
```
Then, try [http://localhost:3000/](http://localhost:3000/)


## Notes

Frontend app, it's pending yet.
