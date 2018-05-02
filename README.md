# Minesweeper

[![Build Status](https://travis-ci.org/aboyon/minesweeper-api.svg?branch=master)](https://travis-ci.org/aboyon/minesweeper-api)

## Summary

This API provides game status persistence for the classic minesweeper game. Code incorporates the logic to build up the game's grid, performs validations, and terminate the game as soon as a bomb it's clicked. Each game belongs to an already registered user. 

The code exposes API endpoints for each operation: 
- Sign up
- Sign In users
- Create/Play games
- explore grid by evaluating the contiguous square in game's matrix.
- Set of unit specs with common cases

```
➜  api git:(master) docker-compose run api bundle exec rake routes
Starting api_db_1 ... done
  Prefix Verb URI Pattern                       Controller#Action
   users POST /users(.:format)                  users#create {:format=>:json}
    user GET  /users/:id(.:format)              users#show {:format=>:json}
         PUT  /games/:id/reveal/:x/:y(.:format) games#reveal {:format=>:json}
   games GET  /games(.:format)                  games#index {:format=>:json}
         POST /games(.:format)                  games#create {:format=>:json}
    game GET  /games/:id(.:format)              games#show {:format=>:json}
sessions POST /sessions(.:format)               sessions#create {:format=>:json}
```

## Install / Setting up

If you're using docker, remember to build the image and run all the rails/rake command through docker-compose (e.g `docker-compose run api bundle exec rspec spec`).

## Clone the repo

```
git clone git@github.com:aboyon/minesweeper-api.git
```

## Classic way - Using rbenv and your host as execution environment

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
