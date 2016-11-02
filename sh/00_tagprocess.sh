#! /bin/bash

TAGINFO_BUILD_DIR=/osm/taginfo/var/sources
TAGINFO_INSTALL_DIR=/osm/data
TAGINFO_DOWNLOAD_DIR=/osm/download


ln -s /osm/cfg/img/dbackground.png     /osm/taginfo/web/public/img/mapbg/dbackground.png   
ln -s /osm/cfg/img/dflag.png           /osm/taginfo/web/public/img/logo/dflag.png
ln -s /osm/cfg/img/dlogo.png           /osm/taginfo/web/public/img/logo/taginfo.png  
ln -s /osm/cfg/taginfo-config.json     /osm/taginfo-config.json                     

# cp /osm/cfg/taginfo-config.json   /osm/taginfo-config.json   


FILE_TAGSTATS=/osm/taginfo/tagstats/tagstats
if [ -f $FILE_TAGSTATS  ];
then
   echo "File $FILE_TAGSTATS  exists."
else
   echo "File $FILE_TAGSTATS  does not exist."
   cd /osm/taginfo/tagstats 
   make clean
   make
fi

mkdir -p /osm/cfg/joblog
mkdir -p /osm/taginfo/var/sources/log

mkdir -p ${TAGINFO_BUILD_DIR}
mkdir -p ${TAGINFO_INSTALL_DIR}
mkdir -p ${TAGINFO_INSTALL_DIR}/old
mkdir -p ${TAGINFO_DOWNLOAD_DIR}


chmod g+s ${TAGINFO_BUILD_DIR}
chmod g+s ${TAGINFO_INSTALL_DIR}
chmod g+s ${TAGINFO_INSTALL_DIR}/old
chmod g+s ${TAGINFO_DOWNLOAD_DIR}

#chmod g+s /osm/taginfo_data/cfg/poly/
#chmod g+s /osm/taginfo_data/cfg/input/


cd /osm/taginfo/sources

./update_all.sh ${TAGINFO_BUILD_DIR}

cp /osm/taginfo/var/sources/log/*  /osm/cfg/joblog/
chmod 644 /osm/cfg/joblog/*

mv -v  ${TAGINFO_INSTALL_DIR}/taginfo-*   ${TAGINFO_INSTALL_DIR}/old/
mv -v  ${TAGINFO_BUILD_DIR}/taginfo-*.db  ${TAGINFO_BUILD_DIR}/*/taginfo-*.db      ${TAGINFO_INSTALL_DIR}
mv -v  ${TAGINFO_BUILD_DIR}/download/*    ${TAGINFO_DOWNLOAD_DIR}


chmod 644 ${TAGINFO_INSTALL_DIR}/*.db
#chmod 644 ${TAGINFO_DOWNLOAD_DIR}/*.db

