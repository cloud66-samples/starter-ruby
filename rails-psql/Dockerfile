# Generated by Cloud66 Starter
FROM ruby:latest

RUN apt-get update -qq && apt-get install -y build-essential 

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
