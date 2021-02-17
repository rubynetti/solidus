FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev && \
    curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
    bash ./nodesource_setup.sh && \
    rm ./nodesource_setup.sh && \
    apt-get install nodejs


# Installa yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn

WORKDIR /app

ARG rails_uid=1000
RUN useradd -u $rails_uid -Um rails && \
    chown -R rails:rails /app
USER rails

RUN mkdir /app/node_modules
