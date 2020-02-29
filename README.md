# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version: 2.7

- System dependencies

- Configuration

  Docker with ruby alpine so check how to use apk

- Database creation

  `rails db:create`

- Database initialization

  `rails db:migrate` and `rails db:seed`

- How to run the test suite

  No test suites for now 😞

- Services (job queues, cache servers, search engines, etc.)

  N/A 😞

- Deployment instructions

This tutorial is used to deploy custom docker for [Azure app service](https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image)

### staging

1. Build `docker build -t supersaver .` and `docker-compose up -d`
2. Do it once `docker tag supersaver supersavercontainer.azurecr.io/supersaver:v1.0.0`
3. Get Azure login creds `az acr credential show --name supersavercontainer`
4. Now login to Azure docker `docker login supersavercontainer.azurecr.io --username supersavercontainer`
4. Push `docker push supersavercontainer.azurecr.io/supersaver:v1.0.0`

### production

- Same as staging
