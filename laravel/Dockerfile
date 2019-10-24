FROM composer:1.9 AS composer

FROM composer AS vendor
# make composer fast in japan
RUN composer config -g repositories.packagist composer https://packagist.jp
RUN composer global require hirak/prestissimo

COPY composer.* ./

# some dependencies need to scan database folder when installing
COPY database database

RUN composer install \
        --ignore-platform-reqs \
        --no-interaction \
        --no-plugins \
        --no-progress \
        --no-scripts \
        --prefer-dist

FROM php:7.3-fpm-alpine3.8 AS php-fpm
RUN docker-php-ext-install pdo_mysql
WORKDIR /var/www/
# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY --from=vendor /app/vendor/ /var/www/vendor/
COPY . /var/www/
