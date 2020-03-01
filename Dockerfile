FROM ruby:2.7-alpine

# Install dependencies
RUN apk update \
&& apk upgrade \
&& apk add --update --no-cache \
build-base postgresql-dev \
tzdata nodejs yarn openssh openrc

# Setup ssh
ENV SSH_PASSWD "root:Docker!"
RUN echo "$SSH_PASSWD" | chpasswd
COPY sshd_config /etc/ssh/

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
COPY Gemfile* package.json yarn.lock ./
RUN bundle config set without 'development test'
RUN bundle install

# Adding project files
COPY . $RAILS_ROOT

# clean and compile rails assets
RUN bin/rails assets:clean
RUN bin/rails assets:precompile

# expose rails port and azure ssh ports
EXPOSE 3000 8000 2222
# start ssh service
RUN rc-update add sshd
# start rails server
CMD ["bundle", "exec", "rails", "s"]