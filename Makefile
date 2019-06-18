# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

export APP     := sretooling/helm

# ensure you create an initial commit on your your git.. `git tag 0.0.1 ; git push origin 0.0.1`
export TAG     := $(shell git describe --tags)
export IMG     := "$(APP):$(TAG)"

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(IMG) .

publish-latest: tag-latest login ## Publish the `latest` taged container to ECR
	@echo 'publish latest to $(DOCKER_REPO)'
	docker push $(APP):latest

publish-version: login ## Publish the `{version}` taged container to ECR
	@echo 'publish $(TAG)'
	docker push $(APP):$(TAG)

tag-latest: ## Generate container `{version}` tag
	@echo 'create tag latest'
	docker tag $(APP):$(TAG) $(APP):latest

# log into dockerhub
login:
	docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)
