FROM ruby:3.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /herigo

WORKDIR /herigo

ADD Gemfile Gemfile.lock /herigo/

RUN gem install bundler
RUN bundle install

ADD . /herigo
