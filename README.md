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

curl -X POST -H "Content-Type: application/json" -d '{"user_id": 1, "title": "Rationality 101", "year": 2022, "start_date": "2022-10-10", "description": "How to be profitable"}' http://127.0.0.1:3000/api/v1/courses

curl -X PATCH -H "Content-Type: application/json" -d '{"description": "How to be reasonable, lovable, and profitable - yay"}' http://127.0.0.1:3000/api/v1/courses/3

curl -X DELETE http://127.0.0.1:3000/api/v1/courses/3

curl -X POST -H "Content-Type: application/json" -d '{"name": "The Cabal", "creator_id": 1, "user_id": 1, "description": "People \"who\" sit around campfire", "public": 1}' http://127.0.0.1:3000/api/v1/groups

curl -X POST -H "Content-Type: application/json" -d '{"post": {"user_id": 1, "post_text": "wat", "context_type": "Group", "context_id": 1}}' http://127.0.0.1:3000/api/v1/posts
```

### User management via Doorkeeper

1. Get a client ID
This Ruby code creates a new application with a client ID:
```
Doorkeeper::Application.create(name: 'Web client', redirect_uri: '', scopes: '')
```

2. User registration (a new user is created and an access token returned)
```
curl -X POST -H "Content-Type: application/json" -d '{"email": "test3@registration.com", "password": "watpassword", "client_id": "vtZABOhi9JdIi4nYl1AH-c7Th4O8tixffyIFwzepZRY"}' http://127.0.0.1:3000/api/v1/users
```

3. Get an access token (the equivalent of user login)
```
curl -X POST -H "Content-Type: application/json" -d '{"grant_type": "password", "email": "test3@registration.com", "password": "watpassword", "client_id": "vtZABOhi9JdIi4nYl1AH-c7Th4O8tixffyIFwzepZRY", "client_secret": "PEHN53a7IpbyXay__RlieQVOuhFq5tkvzFOokTwh1EI"}' http://127.0.0.1:3000/api/v1/oauth/token
```

4. Make a request using the access token returned by the above command
```
curl -H "Authorization: Bearer sZhWT-nxRa9dCm-eo0sZNDBWsCwD_mRL5Tlm8RNBu2I" http://127.0.0.1:3000/api/v1/posts?context_type=Course&context_id=2
```

5. Revoke an access token
```
curl -X POST -H "Content-Type: application/json" -d '{"token": "sZhWT-nxRa9dCm-eo0sZNDBWsCwD_mRL5Tlm8RNBu2I", "client_id": "vtZABOhi9JdIi4nYl1AH-c7Th4O8tixffyIFwzepZRY", "client_secret": "PEHN53a7IpbyXay__RlieQVOuhFq5tkvzFOokTwh1EI"}' http://127.0.0.1:3000/api/v1/oauth/revoke
```

## Unit tests

## Deployment
