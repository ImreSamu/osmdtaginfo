#! /bin/bash

#inputpbf=australia-oceania-latest.osm.pbf
inputpbf=$1

osmium cat ./import/$inputpbf -t way -t relation -f opl |  grep admin_level=2 | grep boundary=administrative | cut  -d ' ' -f1 > ./import/${inputpbf}_admin2_ids.txt
osmium getid ./import/${inputpbf}  -i ./import/${inputpbf}_admin2_ids.txt --add-referenced --overwrite -o ./import/admin2_${inputpbf}

