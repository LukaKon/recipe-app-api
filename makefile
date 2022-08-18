ifneq (,$(wildcard ./.env))
	include .env
	export
	ENV_FILE_PARAM = --env-file .env
endif

# DOCKER
build:
	set -e
	docker compose down
	docker compose up --build -d

up:
	docker compose up -d

stop:
	docker compose stop

down:
	docker compose down

logs:
	docker compose logs

flake:
	docker compose run --rm app sh -c 'flake8'

darker:
	docker compose run --rm app sh -c 'darker .'

test:
	docker compose run --rm app sh -c 'python manage.py test'

migrate:
	docker compose run --rm app sh -c 'python manage.py migrate --noinput'

makemigrations:
	docker compose run --rm app sh -c 'python manage.py makemigrations'

superuser:
	docker compose run --rm app sh -c 'python manage.py createsuperuser'

volume:
	docker volume inspect party_creator_pgdata

shell:
	docker compose run --rm app sh -c 'python manage.py shell_plus'
#	 docker compose exec app python3 manage.py shell_plus

# TODO:
dump:
	docker exec -i postgres_db /bin/bash -c "PGPASSWORD=$(DATABASE_PASSWORD) pg_dump -h localhost --username $(DATABASE_USER) $(DATABASE_NAME)" > dump.sql
	# docker compose exec db pg_dump -c -U ${DATABASE_USER} ${DATABASE_NAME} --no-owner > dump.sql

restore:
	docker exec -i postgres_db /bin/bash -c "PGPASSWORD=$(DATABASE_PASSWORD) psql -h localhost --username $(DATABASE_USER) $(DATABASE_NAME)" < dump.sql
