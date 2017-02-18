


#export CONTINENT_LONG=central-america
#export CONTINENT=ca 
#export START_PORT=5400

#docker-compose run -e CONTINENT_LONG=antarctica        -e CONTINENT=an  -e START_PORT=6200 taginfo_dev  /osm/setup/r.sh    
#docker-compose run -e CONTINENT_LONG=australia-oceania -e CONTINENT=au  -e START_PORT=6400 taginfo_dev  /osm/setup/r.sh

# austrália missing ..
# norfolk - no englsh name ..

#docker-compose run -e CONTINENT_LONG=africa             -e CONTINENT=af  -e START_PORT=6600 taginfo_dev  /osm/setup/r.sh
docker-compose run -e CONTINENT_LONG=central-america   -e CONTINENT=ca  -e START_PORT=6800 taginfo_dev  /osm/setup/r.sh
#docker-compose run -e CONTINENT_LONG=europe            -e CONTINENT=eu  -e START_PORT=6900 taginfo_dev  /osm/setup/r.sh

docker-compose stop db

CONTINENT=ca

cd ./service/$CONTINENT
./service_create.sh
./job.sh
#./service_up.sh

cd ..
cp ${CONTINENT}_index.html ../caddy/index.html
#caddy 
#docker run -d -p 2015:2015 abiosoft/caddy




