FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir -p /devigetapi/api
WORKDIR /devigetapi/api
COPY Gemfile /devigetapi/api/Gemfile
COPY Gemfile.lock /devigetapi/api/Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
COPY . /devigetapi/api