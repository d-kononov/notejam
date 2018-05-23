FROM ruby:2.5.1-slim
MAINTAINER Dmitriy Kononov


RUN apt update && apt-get install -y --force-yes libpq-dev libmariadbclient-dev libsqlite3-dev wget nodejs build-essential \
  && wget -q https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz \
  && gem install foreman \
  && apt-get clean \
  && cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* \
  && truncate -s 0 /var/log/*log

WORKDIR /app
ENV RAILS_ENV production
ONBUILD ADD Gemfile /app/Gemfile
ONBUILD ADD Gemfile.lock /app/Gemfile.lock
ONBUILD RUN bundle install --without development test
ONBUILD ADD . /app
ONBUILD RUN RAILS_ENV=production bundle exec rake assets:precompile

#ADD nginx-sites.conf /etc/nginx/sites-enabled/default
#ADD nginx.conf /etc/nginx/nginx.conf

ADD unicorn.rb /app/config/unicorn.rb
ADD Procfile /app/Procfile

CMD foreman start -f Procfile
