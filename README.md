# Campfire

## Set up development environment
To get the code:
```
git clone https://<username>:<person access token>@github.com/campfire-learning/campfire-web.git
git clone https://<username>:<person access token>@github.com/campfire-learning/campfire-api.git
```

One the token expires, you need to set the remote url with the following command:
```
git remote set-url origin https://<username>:<person access token>@github.com/campfire-learning/campfire-web.git
git remote set-url origin https://<username>:<person access token>@github.com/campfire-learning/campfire-api.git
```

We use Ruby 3.1.2 and Rails 7.0.4. Do not upgrade versions if not necessary.

In side the root folder, run following commands:

1. `brew install ruby` or `brew install rbenv` then `rbenv install 3.1.2` (rbenv is recommended).
2. `bundle install` to install packages.
3. `db/db_refresh.sh` to seed some data into your local database (sqlite by default).
4. `rails s` to start the API server.

## Testing endpoints

```
curl "http://127.0.0.1:3000/api/v1/courses?user_id=1"
curl "http://127.0.0.1:3000/api/v1/courses/2"

curl -X POST -H "Content-Type: application/json" -d '{"creator_id": 1, "owner_id": 1, "title": "Rationality 202", "description": "How to be reasonable and profitable"}' http://127.0.0.1:3000/api/v1/courses

curl -X PATCH -H "Content-Type: application/json" -d '{"creator_id": 1, "owner_id": 1, "title": "Rationality 303", "description": "How to be reasonable, lovable, and profitable"}' http://127.0.0.1:3000/api/v1/courses/3

curl -X DELETE http://127.0.0.1:3000/api/v1/courses/3

curl -X POST -H "Content-Type: application/json" -d '{"name": "The Cabal", "creator_id": 1, "owner_id": 1, "description": "People who sit around campfire", "public": 1}' http://127.0.0.1:3000/api/v1/channels

curl -X POST -H "Content-Type: application/json" -d '{"creator_id": 1, "post_text": "wat", "context_type": 1}' http://127.0.0.1:3000/posts
```

## Set it up

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
