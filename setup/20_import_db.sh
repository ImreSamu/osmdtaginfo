#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

inputpbf=$1

echo "$(date) - importing: $inputpbf "

while ! pg_isready
do
    echo "$(date) - waiting for PG database to start"
    sleep 2
done

readonly PG_CONNECT="postgis://"

 echo "============ Start import_admin ================"

  /tools/latest/imposm3 import \
   -mapping /osm/setup/imposm3_admin_mapping.yml  \
   -read $inputpbf \
   -write    \
   -optimize  \
   -overwritecache \
   -deployproduction \
   -connection $PG_CONNECT

