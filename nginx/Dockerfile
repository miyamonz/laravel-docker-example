FROM nginx:alpine AS nginx

COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=laravel-docker-example_app /var/www/public /var/www/public
