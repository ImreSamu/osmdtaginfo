#! /bin/bash


#cd /osm/setup
#wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip
#unzip ne_10m_admin_0_countries.zip

# export CONTINENT_LONG=australia-oceania CONTINENT=au START_PORT=6400
# export CONTINENT_LONG=africa            CONTINENT=af START_PORT=6600


echo CONTINENT_LONG=$CONTINENT_LONG
echo CONTINENT=$CONTINENT 
echo START_PORT=$START_PORT

    /osm/setup/osmium_admin_filter.sh ${CONTINENT_LONG}-latest.osm.pbf

# import ot PostGIS - with  imposm3 

    /osm/setup/20_import_db.sh /osm/import/admin2_${CONTINENT_LONG}-latest.osm.pbf

# Posgresql postprocessing - calculating parameters for the config    
	psql -a   -P pager=off   -f "/osm/setup/setup_xtaginfo.sql"

# generating config files ->  /osm/service/*
    mkdir -p /osm/service/${CONTINENT}/
	rm -rf /osm/service/${CONTINENT}/*
	python /osm/setup/setup_polygon.py
	python /osm/setup/setup_map.py
	python /osm/setup/setup_config.py
    python /osm/setup/setup_makefile.py
    python /osm/setup/setup_docker.py
    python /osm/setup/setup_readme.py

# chmod settings ...
    find ./service/* -type d -print0 | xargs -0 chmod 0755 # for directories
    find ./service/. -type f -print0 | xargs -0 chmod 0644 # for files
    chmod +x  /osm/service/${CONTINENT}/*.sh
