ARG COMPOSER_OPTION=" \
--ignore-platform-reqs \
--no-interaction \
--no-plugins \
--no-scripts \
--no-progress \
--prefer-dist \
"

FROM composer:1.9 AS composer

FROM composer AS vendor
# make composer fast in japan
RUN composer config -g repositories.packagist composer https://packagist.jp
RUN composer global require hirak/prestissimo

COPY composer.* ./

# some dependencies need to scan database folder when installing
COPY database database

FROM vendor AS vendor-dev
ARG COMPOSER_OPTION
RUN composer install ${COMPOSER_OPTION}

FROM vendor AS vendor-prod
ARG COMPOSER_OPTION
RUN composer install --no-dev ${COMPOSER_OPTION}

FROM php:7.3-fpm-alpine3.8 AS php-fpm
RUN docker-php-ext-install pdo_mysql
WORKDIR /var/www/

FROM php-fpm AS php-fpm-dev
# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=vendor-dev /app/vendor/ /var/www/vendor/
COPY . /var/www/

FROM php-fpm AS php-fpm-prod
COPY --from=vendor-prod /app/vendor/ /var/www/vendor/
COPY --from=laravel-docker-example_node /code/public/js /var/www/public/js
COPY --from=laravel-docker-example_node /code/public/css /var/www/public/css
COPY --from=laravel-docker-example_node /code/public/mix-manifest.json /var/www/public/
COPY . /var/www/

