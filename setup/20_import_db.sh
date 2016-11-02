#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

while ! pg_isready
do
    echo "$(date) - waiting for PG database to start"
    sleep 2
done

readonly PG_CONNECT="postgis://"

function import_admin {
 echo "============ Start import_admin ================"
 for input_osm_pbf in "/osm/import/*.pbf"; do
  /tools/latest/imposm3 import \
   -mapping /osm/setup/imposm3_admin_mapping.yml  \
   -read $input_osm_pbf \
   -write    \
   -optimize  \
   -overwritecache \
   -deployproduction \
   -connection $PG_CONNECT
  break
 done
}
import_admin

