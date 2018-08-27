FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential curl libpq-dev nodejs
RUN gem install rails

WORKDIR /app
VOLUME ["/usr/local/bundle"]
