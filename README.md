# kaiba

WIP

I prepared simple dockerfiles to run laravel.


I only considered development phase.
In production, some stages will be added in dockerfile
 - to remove data which are required only in devlopment
 - to make volumes persistent

## develop
You can see default laravel top page with

$ docker-compose up

and access to http://localhost:8080

when you run composer or php artisan
$ docker-compose exec app bash

and run commands.
or simplly `docker-compose exec app composer install`  and so on
