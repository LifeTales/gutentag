FROM ruby:2.5-alpine

ENV APP_HOME /app

RUN apk update && apk add build-base nodejs mysql-dev postgresql-dev sqlite-dev git

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile gutentag.gemspec ./
RUN bundle install --binstubs

ENTRYPOINT ["bundle", "exec"]

