
# setup code,  only works for me ... 

# start from the development image  ( `make dev``)
# or:   docker-compose run --rm taginfo_dev /bin/bash


# Add this files to the ./setup/ dirs ... need for generating backgroud maps ..
# ne_10m_admin_0_countries.cpg
# ne_10m_admin_0_countries.dbf
# ne_10m_admin_0_countries.prj
# ne_10m_admin_0_countries.shp
# ne_10m_admin_0_countries.shx


# import ot PostGIS - with  imposm3 
	/osm/setup/20_import_db.sh

# Posgresql postprocessing - calculating parameters for the config    
	psql -a -f "/osm/setup/setup_xtaginfo.sql"

# generating config files ->  /osm/export/*
	rm -rf /osm/export/*
	python /osm/setup/setup_polygon.py
	python /osm/setup/setup_map.py
	python /osm/setup/setup_config.py
    python /osm/setup/setup_makefile.py
    python /osm/setup/setup_docker.py
    python /osm/setup/setup_readme.py

# chmod settings ...
    find ./export/* -type d -print0 | xargs -0 chmod 0755 # for directories
    find ./export/. -type f -print0 | xargs -0 chmod 0644 # for files

#  manual copy of the files:
    #   /osm/export/* ->  /osm/taginfo_data/*
    #   update project files ...
    #   /osm/export/Makefile -> 
    #   /osm%export/docker-compose.yml ->


#....
