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
You can use the following `curl` commands to quickly test some endpoints:
```
curl "http://127.0.0.1:3000/api/v1/courses?user_id=1"
curl "http://127.0.0.1:3000/api/v1/courses/2"
curl -X POST -H "Content-Type: application/json" -d '{"user_id": 1, "title": "Rationality 101", "year": 2022, "start_date": "2022-10-10"}' http://127.0.0.1:3000/api/v1/courses

curl -X PATCH -H "Content-Type: application/json" -d '{"title": "Rationality 102"}' http://127.0.0.1:3000/api/v1/courses/3
curl -X DELETE http://127.0.0.1:3000/api/v1/courses/3
curl -X POST -H "Content-Type: application/json" -d '{"name": "The Cabal", "creator_id": 1, "user_id": 1, "public": 1}' http://127.0.0.1:3000/api/v1/interests

curl -X POST -H "Content-Type: application/json" -d '{"post": {"user_id": 1, "post_text": "wat", "context_type": "Interest", "context_id": 1}}' http://127.0.0.1:3000/api/v1/posts
```

### User management via Doorkeeper

1. Create an OAuth client - this Ruby code creates a new application with an OAuth client ID and client secret:
```
Doorkeeper::Application.create(name: 'My Oauth Client', redirect_uri: '', scopes: '')
```

2. User registration (for the given client, a new user is created and an access token returned)
```
curl -X POST -H "Content-Type: application/json" -d '{"email": "test3@registration.com", "password": "watpassword", "user_type": "student", "institution_id": 1, "client_id": "XdPRSNmZyIuik3fVt4YNx56KHj5swEFCVajz7GaDPFw"}' http://127.0.0.1:3000/api/v1/users

curl -X POST -H "Content-Type: application/json" -d '{"first_name": "foo", "last_name": "bar", "user_type": "student", "email": "test4@registration.com", "password": "watpassword", "institution_id": 1, "client_id": "XdPRSNmZyIuik3fVt4YNx56KHj5swEFCVajz7GaDPFw"}' http://127.0.0.1:3000/api/v1/users
```

3. Get an access token and a refresh token (the equivalent of user login) - `client_secret` not required:
```
curl -X POST -H "Content-Type: application/json" -d '{"email": "tony@campfire.com", "password": "to_be_determined_at_runtime", "client_id": "XdPRSNmZyIuik3fVt4YNx56KHj5swEFCVajz7GaDPFw"}' http://127.0.0.1:3000/api/v1/users/login
```

4. Get an access token and a refresh token (the equivalent of user login) - `client_secret` required:
```
curl -X POST -H "Content-Type: application/json" -d '{"grant_type": "password", "email": "tony@campfire.com", "password": "to_be_determined_at_runtime", "client_id": "XdPRSNmZyIuik3fVt4YNx56KHj5swEFCVajz7GaDPFw", "client_secret": "KW9_sXyBZ4qEK9MFFoNVJs-UGciTlyDKjTEgnPAGXyQ"}' http://127.0.0.1:3000/api/v1/oauth/token
```

5. Make a request using the access token returned by the above command
```
curl -H "Authorization: Bearer daVj1JpB7hYpM4zLg9RqdI2onpjsHjaXa2Y8P6jWlRI" http://127.0.0.1:3000/api/v1/posts?context_type=Course&context_id=1

curl -H "Authorization: Bearer daVj1JpB7hYpM4zLg9RqdI2onpjsHjaXa2Y8P6jWlRI" http://localhost:3000/api/v1/posts?context_type=Interest&context_id=1


curl -H "Authorization: Bearer daVj1JpB7hYpM4zLg9RqdI2onpjsHjaXa2Y8P6jWlRI" http://127.0.0.1:3000/api/v1/courses?user_id=1
```

6. Revoke an access token
```
curl -X POST -H "Content-Type: application/json" -d '{"token": "sZhWT-nxRa9dCm-eo0sZNDBWsCwD_mRL5Tlm8RNBu2I", "client_id": "vtZABOhi9JdIi4nYl1AH-c7Th4O8tixffyIFwzepZRY", "client_secret": "PEHN53a7IpbyXay__RlieQVOuhFq5tkvzFOokTwh1EI"}' http://127.0.0.1:3000/api/v1/oauth/revoke
```

## Testing
Need more!

## Run Campfire in Docker Compose locally
You can build a new Docker image by running "`docker build -t campfire-api .`" in the repo's root directory.

You can start a container by running:
```
docker run -e RAILS_ENV=development -v `pwd`/db/development.sqlite3:/app/campfire-api/db/development.sqlite3 -p 3000:3000 campfire-api
```

If you want a nice UI to manage your Docker resources on your computer, you can use `portainer` to do so:
```
docker container run -d \
  -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```
then go to `http://localhost:9000`.

## Deployment
See the `k8s` directory.