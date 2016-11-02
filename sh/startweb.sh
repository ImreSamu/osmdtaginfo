#! /bin/sh

ln -s /osm/cfg/img/dbackground.png     /osm/taginfo/web/public/img/mapbg/dbackground.png   
ln -s /osm/cfg/img/dflag.png           /osm/taginfo/web/public/img/logo/dflag.png
ln -s /osm/cfg/img/dlogo.png           /osm/taginfo/web/public/img/logo/taginfo.png  
ln -s /osm/cfg/taginfo-config.json     /osm/taginfo-config.json                     

cd /osm/taginfo/web
echo "--- $HOSTNAME ip adress -> browser  x.x.x.x:4567  -----------"
cat /etc/hosts | grep $HOSTNAME
echo "---------------------------"
./taginfo.rb 4567