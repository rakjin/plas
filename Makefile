DOCKER = docker
IMAGE_PREFIX = plas-examples

DOCKERFILES = $(sort $(wildcard Dockerfile.*))
# Dockerfile.haskell Dockerfile.java Dockerfile.javascript ...
PL_ENVS = $(subst ., ,  $(suffix $(DOCKERFILES)))
# haskell java javascript ...

all : run

# build

build: $(foreach PL_ENV, $(PL_ENVS), build-$(PL_ENV))

define build
build-$(PL_ENV) : Dockerfile.$(PL_ENV)
	$(DOCKER) build --file=Dockerfile.$(PL_ENV) --tag $(IMAGE_PREFIX)-$(PL_ENV) .
endef
$(foreach PL_ENV, $(PL_ENVS), $(eval $(build)))


# run examples

run : $(foreach PL_ENV, $(PL_ENVS), run-$(PL_ENV))

define run
run-$(PL_ENV) : build-$(PL_ENV)
	$(DOCKER) run --rm=true $(IMAGE_PREFIX)-$(PL_ENV) ./run-examples.sh $(PL_ENV)
endef
$(foreach PL_ENV, $(PL_ENVS), $(eval $(run)))


# open sh

define sh
sh-$(PL_ENV) : build-$(PL_ENV)
	$(DOCKER) run --rm=true -it $(IMAGE_PREFIX)-$(PL_ENV) /bin/sh
endef
$(foreach PL_ENV, $(PL_ENVS), $(eval $(sh)))


# clean

rm :
	$(DOCKER) ps -a --format="{{.Image}}\t{{.ID}}" | grep $(IMAGE_PREFIX) | cut -f2 | xargs -i $(DOCKER) stop {} | xargs -i $(DOCKER) rm {}

rmi : rm
	$(DOCKER) images -a --format="{{.Repository}}\t{{.ID}}" | grep $(IMAGE_PREFIX) | cut -f2 | xargs -i $(DOCKER) rmi {}

rmi-dangling :
	$(DOCKER) images -aq --filter=dangling=true | xargs -i $(DOCKER) rmi {}

clean : rm rmi rmi-dangling


.PHONY: \
	build \
	$(foreach PL_ENV, $(PL_ENVS), build-$(PL_ENV)) \
	run \
	$(foreach PL_ENV, $(PL_ENVS), run-$(PL_ENV)) \
	$(foreach PL_ENV, $(PL_ENVS), sh-$(PL_ENV)) \
	rm \
	rmi \
	rmi-dangling \
	clean \
