FROM 2.3.1-alpine

RUN mkdir -p /usr/src/who
WORKDIR /usr/src/who

COPY Gemfile /usr/src/who
COPY Gemfile.lock /usr/src/who

RUN gem install bundler

COPY . /usr/src/who

CMD ["tail -f /dev/null"]