#! /bin/bash

rm -f ./import/*
wget -q -N http://download.geofabrik.de/central-america-latest.osm.pbf  -P ./import
ls -la ./import/*
make build
echo " Start test  ni - Nicaragua "
docker-compose run --rm taginfo_job_ni /osm/sh/osm_split.sh
docker-compose run --rm taginfo_job_ni /osm/sh/osm_jobinit.sh

