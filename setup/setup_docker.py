from jinja2 import Template
from jinja2 import Environment
from jinja2 import FileSystemLoader

import os
import sys
import yaml
import psycopg2
import datetime

reload(sys)
sys.setdefaultencoding('utf-8')


script_root = os.path.dirname(__file__)

try:
  conn_string="dbname=osm user=osm " 
  conn = psycopg2.connect(conn_string)
except:
  print "Connection to database failed"
  sys.exit()

CONTINENT       = os.environ.get('CONTINENT',  'xx')
CONTINENT_LONG  = os.environ.get('CONTINENT_LONG',  'xx_l')
START_PORT = int( os.environ.get('START_PORT', '2000') )

def run_config_gen():
        curiso = conn.cursor()
        try:
          curiso.execute(""" 
              select iso , name_en, port_order from xtaginfo order by iso;
          """)
          rows = curiso.fetchall()
        except:
          print "Postgresql Query could not be executed"
          sys.exit()

        items = []  
        for row in rows:  
            an_item = dict(iso=row[0], name_en=row[1], port_order= START_PORT + row[2] )
            items.append(an_item)


        if len(items)>0:  
            createdocker_config(items)  
            create_indexpage(items)
            create_job(items)
            create_service_create(items)
            create_service_up(items)
            create_service_down(items)
        else:
            print " Empy / bad  SQL query -  check !!!" 

        #print items


def createdocker_config(items):

    template_name = 'docker-compose.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        continent=CONTINENT,
        continent_long=CONTINENT_LONG,
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf.encode('utf-8')


    dockerconfig_directory='/osm/service/'+ CONTINENT +'/' 
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)


    fconf = open( dockerconfig_directory + 'docker-compose.yml', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()



def create_indexpage(items):

    template_name = 'index.html.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        continent=CONTINENT,
        continent_long=CONTINENT_LONG,        
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf.encode('utf-8')

    dockerconfig_directory='/osm/service/'
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)

    fconf = open( dockerconfig_directory + CONTINENT + '_index.html', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()


def create_job(items):
    
    template_name = 'job.sh.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        continent=CONTINENT,
        continent_long=CONTINENT_LONG,        
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf.encode('utf-8')

    dockerconfig_directory='/osm/service/'+ CONTINENT +'/'
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)

    fconf = open( dockerconfig_directory + 'job.sh', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()



def create_service_create(items):
    
    template_name = 'service_create.sh.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        continent=CONTINENT,
        continent_long=CONTINENT_LONG,        
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf.encode('utf-8')

    dockerconfig_directory='/osm/service/'+ CONTINENT +'/'
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)

    fconf = open( dockerconfig_directory  + 'service_create.sh', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()



def create_service_up(items):
    
    template_name = 'service_up.sh.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        continent=CONTINENT,
        continent_long=CONTINENT_LONG,        
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf.encode('utf-8')

    dockerconfig_directory='/osm/service/'+ CONTINENT +'/'
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)

    fconf = open( dockerconfig_directory  + 'service_up.sh', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()


def create_service_down(items):
    
    template_name = 'service_down.sh.jinja2'
    environment = Environment(loader=FileSystemLoader(script_root))
    template = environment.get_template(template_name)
    tagconf = template.render(
        items=items,
        continent=CONTINENT,
        continent_long=CONTINENT_LONG,        
        utcnow=datetime.datetime.utcnow().strftime('%Y-%m-%d:%H:%M').decode("utf8"),
    )
    print tagconf.encode('utf-8')

    dockerconfig_directory='/osm/service/'+ CONTINENT +'/'
    if not os.path.exists(dockerconfig_directory):
         os.makedirs(dockerconfig_directory)

    fconf = open( dockerconfig_directory + 'service_down.sh', 'w')
    fconf.write(tagconf.encode("utf8"))
    fconf.close()

run_config_gen()
