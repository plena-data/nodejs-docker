#!/bin/bash

IMAGE_NAME=${1:-google-nodejs}

# Build a Docker image.
function build {
	echo "Building image '$IMAGE_NAME'..."
	npm run compile
	docker build \
		--build-arg GIT_COMMIT=$(git log -1 --format=%H) \
		--build-arg GIT_BRANCH=$(git branch --show-current) \
		-t gcr.io/plena-prod/$IMAGE_NAME:latest .
	echo "Build complete."
	# echo "Pushing image '$IMAGE_NAME'..."
	docker push gcr.io/plena-prod/$IMAGE_NAME:latest
	echo "Push complete."

}

build
