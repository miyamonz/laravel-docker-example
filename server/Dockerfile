FROM composer:1.9 AS composer

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

FROM php:fpm
WORKDIR /var/www/
COPY . /var/www/


# copy vendor folder
COPY --from=composer /app/vendor/ /var/www/vendor/

# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer /usr/bin/composer /usr/bin/composer
