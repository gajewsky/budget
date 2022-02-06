## Initial setup
```
cp .env.example .env
docker-compose build
docker-compose run web bin/rails db:setup
```
