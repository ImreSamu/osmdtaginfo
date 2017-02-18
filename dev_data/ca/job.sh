# generated : 2017-02-15:23:07  // template : ./setup/job.sh.jinja2


 echo " Start processing ca_ag - Antigua and Barbuda "
 time docker-compose run --rm taginfo_job_ca_ag /osm/sh/osm_split.sh
 time docker-compose run --rm taginfo_job_ca_ag /osm/sh/osm_jobinit.sh
 time docker-compose restart taginfo_view_ca_ag


 echo " Start processing ca_ai - Anguilla "
 time docker-compose run --rm taginfo_job_ca_ai /osm/sh/osm_split.sh
 time docker-compose run --rm taginfo_job_ca_ai /osm/sh/osm_jobinit.sh
 time docker-compose restart taginfo_view_ca_ai



# generated : 2017-02-15:23:07