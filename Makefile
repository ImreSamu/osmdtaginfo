# generated : 2016-11-02:17:43  // template : ./setup/Makefile.jinja2
.PHONY: all

all: build

build:
	cd ./docker && docker build -t taginfo_job  -f taginfo_job.Dockerfile  . && cd ..
	cd ./docker && docker build -t taginfo_view -f taginfo_view.Dockerfile . && cd ..
	docker images | grep taginfo

dev:
	docker-compose run --rm taginfo_dev /bin/bash
	
dev_job:
	docker run -it --rm taginfo_job /bin/bash

dev_view: 
	docker run -it --rm taginfo_view /bin/bash

down:
	docker-compose down

