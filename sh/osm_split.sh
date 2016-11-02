#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

#/osm/osm-history-splitter/build/src/osm-history-splitter --debug --hardcut  /osm/import/central-america-latest.osm.pbf  osm_splitter.config


osmconvert /osm/import/central-america-latest.osm.pbf  -B=/osm/cfg/poly/osm.poly -o=/osm/cfg/input/area.osm.pbf
chmod 644 /osm/cfg/input/area.osm.pbf




