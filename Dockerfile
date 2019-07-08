FROM php:7.1.30-cli-alpine3.9

# Packages
RUN apk --update add \
    autoconf \
    libevent-dev \
    openldap-dev \
    imagemagick-dev && \
    docker-php-ext-install pdo_mysql opcache sockets && \
    docker-php-ext-enable sockets && \
    pecl install event-2.5.3 && \
    docker-php-ext-enable event && \
    docker-php-ext-enable opcache \
    && rm -rf /var/cache/apk/*




ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 1.5.1


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
 && composer --ansi --version --no-interaction

VOLUME /var/www
WORKDIR /var/www

CMD [ "php", "./public/server.php" ]
