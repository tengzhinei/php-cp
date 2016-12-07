FROM php:7.0

# install phpredis extension
ENV PHPREDIS_VERSION 3.0.0

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# build php-cp
COPY . /usr/src/php/ext/php-cp
RUN docker-php-ext-install php-cp
COPY ./pool.ini /etc/pool.ini

# Workdir
COPY . /usr/src/php-cp
WORKDIR /usr/src/php-cp