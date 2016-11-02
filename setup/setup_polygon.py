# -*- coding: utf-8 -*-
#!/usr/bin/python2.7

#description     :  
#author          :  
#date            :  
#version         :  0.1
#usage           :  python setup_polygon.py
#==============================================================================

import psycopg2
import os
import sys
import os, atexit
import re

try:
  conn_string="dbname=osm user=osm " 
  conn = psycopg2.connect(conn_string)
except:
  print "Connection to database failed"




def qiso():

        curiso = conn.cursor()
        try:
          curiso.execute(""" 
              select iso, id  from xtaginfo order by iso
          """)
  
          rows = curiso.fetchall()

          for row in rows:
                print "processing: ", row[0] , row[1]
                createisopoly(row[0],row[1] )
                ## print "   ", row[1],"  ;; ", row[2]

        except:
          print "Postgresql Query could not be executed"



def show(f,s):
    f.write ( s.encode("utf8") )
    f.write ( '\n'.encode("utf8") )

def write_polygon(f, wkt, p):

        match = re.search("^\(\((?P<pdata>.*)\)\)$", wkt)
        pdata = match.group("pdata")
        rings = re.split("\),\(", pdata)

        first_ring = True
        for ring in rings:
                coords = re.split(",", ring)

                p = p + 1
                if first_ring:
                        f.write(str(p) + "\n")
                        first_ring = False
                else:
                        f.write("!" + str(p) + "\n")

                for coord in coords:
                        ords = coord.split()
                        f.write("\t%E\t%E\n" % (float(ords[0]), float(ords[1])))

                f.write("END\n")

        return p

def write_multipolygon(f, wkt):

        match = re.search("^MULTIPOLYGON\((?P<mpdata>.*)\)$", wkt)

        if match:
                mpdata = match.group("mpdata")
                polygons = re.split("(?<=\)\)),(?=\(\()", mpdata)

                p = 0
                for polygon in polygons:
                        p = write_polygon(f, polygon, p)

                return

        match = re.search("^POLYGON(?P<pdata>.*)$", wkt)
        if match:
                pdata = match.group("pdata")
                write_polygon(f, pdata, 0)





def createisopoly(iso,id):

        cur = conn.cursor()
        try:
                cur.execute("""
                  select ST_AsText(
                  (SELECT   st_transform( st_buffer( geometry, 0.01) , 4326 )  
                    from xtaginfo  where id = {0}  ))
                """.format(id))

                data_tuples = []
                for row in cur:
                        data_tuples.append(row)

        except:
                print "Query could not be executed"

        results = data_tuples 

        wkt = results[0][0]

        img_directory='/osm/export/'+iso+'/img/'
        if not os.path.exists(img_directory):
            os.makedirs(img_directory)

        data_directory='/osm/export/'+iso+'/data/'
        if not os.path.exists(data_directory):
            os.makedirs(data_directory)

        input_directory='/osm/export/'+iso+'/input/'
        if not os.path.exists(input_directory):
            os.makedirs(input_directory)

        joblog_directory='/osm/export/'+iso+'/joblog/'
        if not os.path.exists(joblog_directory):
            os.makedirs(joblog_directory)

        poly_directory='/osm/export/'+iso+'/poly/'
        if not os.path.exists(poly_directory):
            os.makedirs(poly_directory)

        fpoly = open( poly_directory+'osm.poly', 'w')
        show(fpoly,u"polygon")
        write_multipolygon(fpoly, wkt)
        show(fpoly,u"END")
        fpoly.close()



qiso()
