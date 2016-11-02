# Dockerizing the OSM Taginfo  [![Build Status](https://api.travis-ci.org/ImreSamu/osmdtaginfo.svg?branch=master)](https://travis-ci.org/ImreSamu/osmdtaginfo)

## Vision : 

[OSM taginfo](http://taginfo.openstreetmap.org/) for every country in the Earth !

Example URLS for "Central America" ( not exists yet )  
* https://ag.taginfo.openstreetmap.org    // taginfo for :   "Antigua and Barbuda"  
* https://ai.taginfo.openstreetmap.org    // taginfo for :   "Anguilla"  
* https://bb.taginfo.openstreetmap.org    // taginfo for :   "Barbados"  
* https://bs.taginfo.openstreetmap.org    // taginfo for :   "The Bahamas"  
* https://cr.taginfo.openstreetmap.org    // taginfo for :   "Costa Rica"  
* https://cu.taginfo.openstreetmap.org    // taginfo for :   "Cuba"  
* https://dm.taginfo.openstreetmap.org    // taginfo for :   "Dominica"  
* https://do.taginfo.openstreetmap.org    // taginfo for :   "Dominican Republic"  
* https://gd.taginfo.openstreetmap.org    // taginfo for :   "Grenada"  
* https://hn.taginfo.openstreetmap.org    // taginfo for :   "Honduras"  
* https://ht.taginfo.openstreetmap.org    // taginfo for :   "Haiti"  
* https://jm.taginfo.openstreetmap.org    // taginfo for :   "Jamaica"  
* https://kn.taginfo.openstreetmap.org    // taginfo for :   "Saint Kitts and Nevis"  
* https://ky.taginfo.openstreetmap.org    // taginfo for :   "Cayman Islands"  
* https://lc.taginfo.openstreetmap.org    // taginfo for :   "Saint Lucia"  
* https://ms.taginfo.openstreetmap.org    // taginfo for :   "Montserrat"  
* https://ni.taginfo.openstreetmap.org    // taginfo for :   "Nicaragua"  
* https://nl.taginfo.openstreetmap.org    // taginfo for :   "The Netherlands"  
* https://pa.taginfo.openstreetmap.org    // taginfo for :   "Panama"  
* https://sv.taginfo.openstreetmap.org    // taginfo for :   "El Salvador"  
* https://tc.taginfo.openstreetmap.org    // taginfo for :   "Turks and Caicos Islands"  
* https://tt.taginfo.openstreetmap.org    // taginfo for :   "Trinidad and Tobago"  
* https://vc.taginfo.openstreetmap.org    // taginfo for :   "Saint Vincent and the Grenadines"  
* https://vg.taginfo.openstreetmap.org    // taginfo for :   "British Virgin Islands"  
* ....


## Roadmap ( for 2017 ) :

- [x] Dockerize github.com/taginfo/taginfo
- [x] Generate country configs - working protoype to central-america 
- [ ] Travis test 
- [ ] Generate reverse proxy defs: [Træfɪk?](https://github.com/containous/traefik) 
- [ ] Generate country configs ( Africa - priority for humanitarian reasons) 
- [ ] Generate country configs ( Europe, America, Asia, Australia ) 
- [ ] Minimal online test server for the users ( for ~ 10-40 countries )
- [ ] Optimize country configs ( images, parameters, ... )  
- [ ] Security optimalisation, checks ..
- [ ] Performance tests
- [ ] Space, memory optimalisation ( now 60Mb / country + 4Gb for data processing )
- [ ] Daily / 24h data refresh 
- [ ] Documentations
- [ ] 1 hour data refresh ( for some countries ) - for humanitarian reasons! ( support HOT ! )
- [ ] Move repository to the  github.org/taginfo  repository 
- [ ] Find hosting ... ( ag.taginfo.openstreetmap.org )
- [ ] Generate config for : regions (admin_level=4 )  
- [ ] Generate config for : cities,districts (admin_level=8,9 ) ( like: budapest.taginfo.openstreetmap.hu )    
- [ ] Generate taginfo config for : OSM Tasking Manager Projects .. (like:  hotosm-project-2246.taginfo.hotosm.org )
- [ ] [POSM (Portable OpenStreetMap Server)](https://github.com/AmericanRedCross/posm) integration  2 instance [ global and for local extracts )[posm #142](https://github.com/AmericanRedCross/posm/issues/142) 
- [ ] More Taginfo customisation, extending user defined reports

## What you can test NOW:

* Test system for: `central-america-latest.osm.pbf`
* tested with : 
  *  Docker version 1.12.2        (`docker --version `)
  *  docker-compose version 1.8.1 (`docker-compose --version`)

#### Test step 0: ( git clone;  download data ;  build containers, ...)
* `git clone https://github.com/ImreSamu/osmdtaginfo.git`
* `cd osmdtaginfo`
* `./test.sh`

#### Test 'ht'  -  Haiti :
* `make test_ht`

* check the ip adress in the log or with docker inspect ...
```log
--- 18646c64e1df ip adress -> browser  x.x.x.x:4567  -----------
172.21.0.3	18646c64e1df
---------------------------
[2016-11-02 19:01:27] INFO  WEBrick 1.3.1
[2016-11-02 19:01:27] INFO  ruby 2.3.1 (2016-04-26) [x86_64-linux-musl]
== Sinatra (v1.4.7) has taken the stage on 4567 for production with backup from WEBrick
[2016-11-02 19:01:27] INFO  WEBrick::HTTPServer#start: pid=13 port=4567
```
*  go with a browser   x.x.x.x:4567   ( in my example: [172.21.0.3:4527](http://172.21.0.3:4527) )
to finish:   ctr-c  ->  stop the containers ...
*  `make down` 
*  `make clean`

( Be aware the browser cache -  Chrome: Hold down Ctrl and click the Reload button! )


### Available Central-America tests:

* `make test_ag`     # test taginfo for:  "Antigua and Barbuda"  
* `make test_ai`     # test taginfo for:  "Anguilla"  
* `make test_bb`     # test taginfo for:  "Barbados"  
* `make test_bs`     # test taginfo for:  "The Bahamas"  
* `make test_cr`     # test taginfo for:  "Costa Rica"  
* `make test_cu`     # test taginfo for:  "Cuba"  
* `make test_dm`     # test taginfo for:  "Dominica"  
* `make test_do`     # test taginfo for:  "Dominican Republic"  
* `make test_gd`     # test taginfo for:  "Grenada"  
* `make test_hn`     # test taginfo for:  "Honduras"  
* `make test_ht`     # test taginfo for:  "Haiti"  
* `make test_jm`     # test taginfo for:  "Jamaica"  
* `make test_kn`     # test taginfo for:  "Saint Kitts and Nevis"  
* `make test_ky`     # test taginfo for:  "Cayman Islands"  
* `make test_lc`     # test taginfo for:  "Saint Lucia"  
* `make test_ms`     # test taginfo for:  "Montserrat"  
* `make test_ni`     # test taginfo for:  "Nicaragua"  
* `make test_nl`     # test taginfo for:  "The Netherlands"  
* `make test_pa`     # test taginfo for:  "Panama"  
* `make test_sv`     # test taginfo for:  "El Salvador"  
* `make test_tc`     # test taginfo for:  "Turks and Caicos Islands"  
* `make test_tt`     # test taginfo for:  "Trinidad and Tobago"  
* `make test_vc`     # test taginfo for:  "Saint Vincent and the Grenadines"  
* `make test_vg`     # test taginfo for:  "British Virgin Islands"  

### Generating configurations ..

... not tested ..
... see ./setup/run_setup_steps.sh 

