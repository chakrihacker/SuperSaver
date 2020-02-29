FROM ruby:2.7-alpine

# Install dependencies
RUN apk update \
&& apk upgrade \
&& apk add --update --no-cache \
build-base postgresql-dev \
tzdata nodejs yarn

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /super-rails
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV='production'
ENV NODE_ENV='production'
ENV RACK_ENV='production'

# Adding gems
RUN gem install bundler
COPY Gemfile* package.json yarn.lock ./
RUN bundle config set without 'development test'
RUN bundle install

# Adding project files
COPY . $RAILS_ROOT

# compile rails assets
RUN bin/rails assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s"]