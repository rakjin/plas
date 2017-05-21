DOCKER = docker
IMAGE_PREFIX = plas-runner

all : build-runner

# build

build-runner : \
	build-runner-java \
	build-runner-haskell \
	;

build-runner-java : Dockerfile.java
	$(DOCKER) build --file=Dockerfile.java --tag $(IMAGE_PREFIX)-java .

build-runner-haskell : Dockerfile.haskell
	$(DOCKER) build --file=Dockerfile.haskell --tag $(IMAGE_PREFIX)-haskell .


# run

run : \
	run-java \
	run-haskell \
	;

run-java : build-runner-java
	$(DOCKER) run $(IMAGE_PREFIX)-java ./run-examples.sh java

run-haskell : build-runner-haskell
	$(DOCKER) run $(IMAGE_PREFIX)-haskell ./run-examples.sh haskell


# clean

rm :
	$(DOCKER) ps -a --format="{{.Image}}\t{{.ID}}" | grep $(IMAGE_PREFIX) | cut -f2 | xargs -i $(DOCKER) stop {} | xargs -i $(DOCKER) rm {}

rmi : rm
	$(DOCKER) images -a --format="{{.Repository}}\t{{.ID}}" | grep $(IMAGE_PREFIX) | cut -f2 | xargs -i $(DOCKER) rmi {}

rmi-dangling :
	$(DOCKER) images -aq --filter=dangling=true | xargs -i $(DOCKER) rmi {}

clean : rm rmi rmi-dangling


.PHONY: \
	build-runner \
	build-runner-java \
	build-runner-haskell \
	run \
	run-java \
	run-haskell \
	rm \
	rmi \
	rmi-dangling \
	clean \
