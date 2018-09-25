TAG = 1.0.0
DOCKERORG = quay.io/philbrookes
API_IMAGE_NAME = slow-api-server

.phony: build_and_push
build_and_push: build_image push


.phony: push
push:
	docker push $(DOCKERORG)/$(API_IMAGE_NAME):$(TAG)

.phony: build_image
build_image: build_binary
	docker build -t $(DOCKERORG)/$(API_IMAGE_NAME):$(TAG) -f ./tmp/build/api/Dockerfile .

.phony: build_binary
build_binary:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./tmp/_output/bin/$(API_IMAGE_NAME) ./cmd/api
