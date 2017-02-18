#! /bin/bash

rm -f ./import/*
wget -q -N http://download.geofabrik.de/central-america-latest.osm.pbf  -P ./import
ls -la ./import/*
make build

docker-compose run -e CONTINENT_LONG=central-america   -e CONTINENT=ca  -e START_PORT=6800 taginfo_dev  /osm/setup/r.sh

CONTINENT=ca
cd ./service/$CONTINENT

### ./service_create.sh

 docker-compose create taginfo_view_ca_ni

### ./job.sh

 echo " Start processing ca_ni - Nicaragua "
 time docker-compose run --rm taginfo_job_ca_ni /osm/sh/osm_split.sh
 time docker-compose run --rm taginfo_job_ca_ni /osm/sh/osm_jobinit.sh
 time docker-compose restart taginfo_view_ca_ni
