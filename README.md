# Campfire

## Set up development environment
Run `db/db_refresh.sh` to seed some data into your local database.

Run `bundle` to install packages then `rails s` to start the API server.

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

* Ruby version - `ruby 3.0.3p157`

* Rails version - `Rails 7.0.3`

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
