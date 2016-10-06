FROM ruby:2.3.1-alpine

RUN apk add --update build-base libffi-dev ruby-dev

RUN mkdir -p /usr/src/who
WORKDIR /usr/src/who

COPY Gemfile /usr/src/who
COPY Gemfile.lock /usr/src/who

RUN gem install bundler && bundle install

COPY . ./

ENTRYPOINT ["bundle", "exec"]
CMD ["tail -f /dev/null"]