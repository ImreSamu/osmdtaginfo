# generated : 2016-11-02:17:43  // template : ./setup/Makefile.jinja2
.PHONY: all

all: build

build:
	cd ./docker && docker build -t taginfo_job  -f taginfo_job.Dockerfile  . && cd ..
	cd ./docker && docker build -t taginfo_view -f taginfo_view.Dockerfile . && cd ..
	docker images | grep taginfo

dev_job:
	docker run -it --rm taginfo_job /bin/bash

dev_view: 
	docker run -it --rm taginfo_view /bin/bash

down:
	docker-compose down

clean:
	docker-compose rm -f -v


test_ag:
	echo " Start test  ag - Antigua and Barbuda "
	docker-compose run --rm taginfo_job_ag /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_ag /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_ag


test_ai:
	echo " Start test  ai - Anguilla "
	docker-compose run --rm taginfo_job_ai /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_ai /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_ai


test_bb:
	echo " Start test  bb - Barbados "
	docker-compose run --rm taginfo_job_bb /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_bb /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_bb


test_bs:
	echo " Start test  bs - The Bahamas "
	docker-compose run --rm taginfo_job_bs /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_bs /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_bs


test_cr:
	echo " Start test  cr - Costa Rica "
	docker-compose run --rm taginfo_job_cr /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_cr /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_cr


test_cu:
	echo " Start test  cu - Cuba "
	docker-compose run --rm taginfo_job_cu /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_cu /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_cu


test_dm:
	echo " Start test  dm - Dominica "
	docker-compose run --rm taginfo_job_dm /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_dm /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_dm


test_do:
	echo " Start test  do - Dominican Republic "
	docker-compose run --rm taginfo_job_do /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_do /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_do


test_gd:
	echo " Start test  gd - Grenada "
	docker-compose run --rm taginfo_job_gd /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_gd /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_gd


test_hn:
	echo " Start test  hn - Honduras "
	docker-compose run --rm taginfo_job_hn /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_hn /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_hn


test_ht:
	echo " Start test  ht - Haiti "
	docker-compose run --rm taginfo_job_ht /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_ht /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_ht


test_jm:
	echo " Start test  jm - Jamaica "
	docker-compose run --rm taginfo_job_jm /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_jm /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_jm


test_kn:
	echo " Start test  kn - Saint Kitts and Nevis "
	docker-compose run --rm taginfo_job_kn /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_kn /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_kn


test_ky:
	echo " Start test  ky - Cayman Islands "
	docker-compose run --rm taginfo_job_ky /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_ky /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_ky


test_lc:
	echo " Start test  lc - Saint Lucia "
	docker-compose run --rm taginfo_job_lc /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_lc /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_lc


test_ms:
	echo " Start test  ms - Montserrat "
	docker-compose run --rm taginfo_job_ms /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_ms /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_ms


test_ni:
	echo " Start test  ni - Nicaragua "
	docker-compose run --rm taginfo_job_ni /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_ni /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_ni


test_nl:
	echo " Start test  nl - The Netherlands "
	docker-compose run --rm taginfo_job_nl /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_nl /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_nl


test_pa:
	echo " Start test  pa - Panama "
	docker-compose run --rm taginfo_job_pa /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_pa /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_pa


test_sv:
	echo " Start test  sv - El Salvador "
	docker-compose run --rm taginfo_job_sv /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_sv /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_sv


test_tc:
	echo " Start test  tc - Turks and Caicos Islands "
	docker-compose run --rm taginfo_job_tc /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_tc /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_tc


test_tt:
	echo " Start test  tt - Trinidad and Tobago "
	docker-compose run --rm taginfo_job_tt /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_tt /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_tt


test_vc:
	echo " Start test  vc - Saint Vincent and the Grenadines "
	docker-compose run --rm taginfo_job_vc /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_vc /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_vc


test_vg:
	echo " Start test  vg - British Virgin Islands "
	docker-compose run --rm taginfo_job_vg /osm/sh/osm_split.sh
	docker-compose run --rm taginfo_job_vg /osm/sh/osm_jobinit.sh
	docker-compose run --rm taginfo_view_vg



# generated : 2016-11-02:17:43