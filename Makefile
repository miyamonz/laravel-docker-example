install:
	cp .env.local .env
	cd laravel && cp .env.example .env
	docker-compose build
	docker-compose up -d
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan migrate

rm-volume:
	docker volume rm laravel-docker-example_{vendor,mysql,node_modules}

install-test:
	docker-compose down
	make rm-volume
	rm .env laravel/.env
	make install

prod:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml build
