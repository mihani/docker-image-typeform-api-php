FROM php:7.4.11-fpm-alpine

ENV APCU_VERSION 5.1.19
ENV XDEBUG_VERSION 3.0.2
ENV COMPOSER_VERSION 2.0.8

RUN apk add --update --no-cache \
        ca-certificates \
        git \
        icu-libs \
        libxml2-dev \
        oniguruma-dev && \
    apk add --update --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev && \
    apk del .build-deps && \
    apk add gosu --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ && \
    addgroup bar && \
    adduser -D -h /home -s /bin/bash -G bar foo

# Composer
RUN curl -sS https://getcomposer.org/installer \
        | php -- --filename=composer --install-dir=/usr/local/bin --version=${COMPOSER_VERSION}

COPY config/php.ini /usr/local/etc/php/php.ini

WORKDIR /srv
