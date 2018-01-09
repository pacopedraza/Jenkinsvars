# Makefile for skycatch/WebAPI_Automation
# Never directly modify the default environment
ENV ?= development

environment = $(ENV)
repo_organization = skycatch
repo_name = $(shell basename $(shell git config --get remote.origin.url) | cut -d. -f1)
repo_full_name = $(repo_organization)/$(repo_name)

# For your machine
git_sha = $(shell git rev-parse --short HEAD)
# For AWS CodePipeline
ifeq ($(git_sha),)
git_sha = $(shell cat git-rev-short)
endif

git_branch = $(shell git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3-)
whoami = $(shell whoami)
container_tag = $(git_sha)

WARN_COLOR=\x1b[33;01m
NO_COLOR=\x1b[0m

ifeq ($(pipeline),gemba)
        account_id="291403077761"
        bucket=skycatch-production-terra-state
        role_arn=arn:aws:iam::291403077761:role/Production-Terraform
else
        account_id="770136283015"
        bucket=skycatch-terra-state
        role_arn=arn:aws:iam::770136283015:role/Development-Terraform
endif

default: build

#include ./terraform/Makefile

build: docker-build

run: build
	docker-compose up -d
	docker ps

package: build

#upload: package aws-upload

test-build:
	# eslint .
	docker-compose --project-name travis_build -f ./test/docker-compose-travis.yml build

test:
	docker-compose --project-name travis_build -f ./test/docker-compose-travis.yml up -d
	./scripts/watchlogs.sh
	docker ps
	docker stats --all --no-stream
	docker exec travisbuild_api_1 ./scripts/dbup.sh # Allows time for db to start... the name of the Docker Container is constructed from the docker-compose-travis.yml
	docker exec travisbuild_api_1 ./scripts/apiup.sh # Allows time for api to start... the name of the Docker Containeris constructed from the docker-compose-travis.yml
	docker exec -it travisbuild_db_1 mysql -hdb -uroot -pskydev -e "DROP DATABASE IF EXISTS apollo_v1_travis;"
	docker exec -it travisbuild_db_1 mysql -hdb -uroot -pskydev -e "CREATE DATABASE IF NOT EXISTS apollo_v1_travis;"
	docker exec travisbuild_api_1 ./scripts/test-docker.sh # Execute the tests
	docker-compose --project-name travis_build -f ./test/docker-compose-travis.yml down

clean: clean-docker-build

docker-build:
	docker build --force-rm --cpu-quota=-1 --cpuset-cpus=0 --memory=10GB -t $(repo_full_name):$(git_sha) .
ifeq ($(TRAVIS),true)
	docker tag $(repo_full_name):$(git_sha) $(repo_full_name):travis-$(TRAVIS_BUILD_NUMBER)
ifeq ($(TRAVIS_BRANCH),master)
	docker tag $(repo_full_name):$(git_sha) $(repo_full_name):"$(TRAVIS_BRANCH)"
else
	docker tag $(repo_full_name):$(git_sha) $(repo_full_name):latest
endif
else
	docker tag $(repo_full_name):$(git_sha) $(repo_full_name):latest
endif

docker-hub-upload:
	@echo "Test Success - Branch($(TRAVIS_BRANCH)) Pull Request($(TRAVIS_PULL_REQUEST)) Tag($(TRAVIS_TAG))"
ifeq ($(TRAVIS),true)
	docker login -e="$(DOCKER_EMAIL)" -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)"
endif
	docker push $(repo_full_name):$(git_sha)

aws-upload:
	$(eval loginstring = $(shell aws ecr get-login --region us-west-2  --no-include-email))
	$(eval aws_ecs_repo_domain = $(subst https://,,$(lastword $(loginstring))))
	@echo "Logging in"
	@$(loginstring)
	docker tag $(repo_full_name):$(git_sha) $(aws_ecs_repo_domain)/$(repo_full_name):latest
	docker tag $(repo_full_name):$(git_sha) $(aws_ecs_repo_domain)/$(repo_full_name):$(git_sha)
	#docker push $(aws_ecs_repo_domain)/$(repo_full_name):$(git_sha)


# Dashes before the commands below indicate a non-zero exit status is okay.
clean-docker-build:
	-docker rm $(repo_full_name):$(git_sha)
	-docker rmi $(repo_full_name):$(git_sha)
	-docker-compose down
	-docker-compose --project-name travis_build -f ./test/docker-compose-travis.yml down

.PHONY: test
