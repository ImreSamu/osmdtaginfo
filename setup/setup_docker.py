from jinja2 import Template
from jinja2 import Environment
from jinja2 import FileSystemLoader

import os.path
import yaml
import psycopg2
import datetime

script_root = os.path.dirname(__file__)

try:
  conn_string="dbname=osm user=osm " 
  conn = psycopg2.connect(conn_string)
except:
  print "Connection to database failed"


def run_config_gen():
        curiso = conn.cursor()
        try:
          curiso.execute(""" 
              select iso , name_en from xtaginfo order by iso
          """)
  
          rows = curiso.fetchall()
        except:
          print "Postgresql Query could not be executed"

        items = []  
        for row in rows:  
            an_item = dict(iso=row[0], name_en=row[1])
            items.append(an_item)


        if len(items)>0:  
            createdocker_config(items)  
        else:
            print " Empy / bad  SQL query -  check !!!" 

        #print items


def createdocker_config(items):

    template_name = 'docker-compose.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf


    dockerconfig_directory='/osm/export/'
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)


    fconf = open( dockerconfig_directory + 'docker-compose.yml', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()




run_config_gen()
