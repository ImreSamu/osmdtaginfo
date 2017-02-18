#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

mkdir -p /osm/cfg/data
mkdir -p /osm/cfg/img
mkdir -p /osm/cfg/input
mkdir -p /osm/cfg/joblog
mkdir -p /osm/cfg/poly

osmium extract /osm/import/${CONTINENT_LONG}-latest.osm.pbf -s simple  -p /osm/cfg/poly/osm.poly -o /osm/cfg/input/area.osm.pbf

chmod 644 /osm/cfg/input/area.osm.pbf




