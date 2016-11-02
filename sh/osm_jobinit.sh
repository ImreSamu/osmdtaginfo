#! /bin/bash

set -o errexit
set -o pipefail
set -o nounset

# first time run: 2x
/osm/sh/00_tagprocess.sh
/osm/sh/00_tagprocess.sh
