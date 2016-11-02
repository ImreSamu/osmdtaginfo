import mapnik
import cairo 
import psycopg2
import os
from shutil import copyfile

try:
  conn_string="dbname=osm user=osm " 
  conn = psycopg2.connect(conn_string)
except:
  print "Connection to database failed"


def run_background_map_gen():
        curiso = conn.cursor()
        try:
          curiso.execute(""" 
              select iso, id, taginfo_scale , name , name_en  from xtaginfo order by iso
          """)
  
          rows = curiso.fetchall()
        except:
          print "Postgresql Query could not be executed"


        for row in rows:
            print "Generating background map: ", row[0] , row[1], row[2][0] , row[2][1] , row[3]
            createisomap(row[0],row[2],row[3],row[4] )





   

def createisomap(iso, mapscale, name , name_en ):

    map_width  = int(mapscale[0])
    map_height = int(mapscale[1])  


    map_minx   = float(mapscale[2])
    map_maxx   = float(mapscale[3])   
    map_miny   = float(mapscale[4])
    map_maxy   = float(mapscale[5])

    print "mapdata:", map_width, map_height, map_maxx, map_maxy,map_minx,map_miny 


    m = mapnik.Map( map_width ,map_height ) # create a map with a given width and height in pixels
    # note: m.srs will default to '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
    # the 'map.srs' is the target projection of the map and can be whatever you wish 
    m.background = mapnik.Color('steelblue') # set background colour to 'steelblue'.  

    s = mapnik.Style() # style object to hold rules
    r = mapnik.Rule() # rule object to hold symbolizers
    # to fill a polygon we create a PolygonSymbolizer
    polygon_symbolizer = mapnik.PolygonSymbolizer(mapnik.Color('#f2eff9'))
    r.symbols.append(polygon_symbolizer) # add the symbolizer to the rule object
    # to add outlines to a polygon we create a LineSymbolizer
    line_symbolizer = mapnik.LineSymbolizer(mapnik.Color('rgb(50%,50%,50%)'),0.1)
    r.symbols.append(line_symbolizer) # add the symbolizer to the rule object
    s.rules.append(r) # now add the rule to the style and we're done

    m.append_style('My Style',s) # Styles are given names only as they are applied to the map

    ds = mapnik.Shapefile(file='/osm/setup/ne_10m_admin_0_countries.shp')


    ds.envelope()

    layer = mapnik.Layer('world') # new layer called 'world' (we could name it anything)
    # note: layer.srs will default to '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'

    layer.datasource = ds
    layer.styles.append('My Style')

    m.layers.append(layer)

    bbox = mapnik.Box2d( map_maxx, map_maxy, map_minx, map_miny )
    m.zoom_to_box(bbox)

    # .zoom_to_box(mapnik.Box2d(   ))
    # m.zoom_all()

    # Write the data to a png image called world.png the current directory
    
    img_directory='/osm/export/'+iso+'/img/'
    if not os.path.exists(img_directory):
         os.makedirs(img_directory)

    mapnik.render_to_file(m,img_directory+'dbackground.png', 'png')



    ######################  flag ##################################


    copyfile('/osm/setup/dflag.png', img_directory+'dflag.png')


    ####################  Logo #####################################

#    surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, 258, 98)
    surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, 348, 98)
    ctx = cairo.Context (surface)
    ctx.select_font_face("Courier", cairo.FONT_SLANT_NORMAL,   cairo.FONT_WEIGHT_BOLD)

    ctx.set_font_size(42) 
    ctx.move_to(2, 50)
    ctx.set_source_rgb(0.0, 0.0, 0.15) 
    ctx.show_text('Taginfo-'+iso)
    
    ctx.select_font_face('Sans') 
    if   len(name_en) > 26 :
           ctx.set_font_size(20)
    elif len(name_en) > 18 :
           ctx.set_font_size(26)
    else:
           ctx.set_font_size(30)

    ctx.move_to(1, 90) 
    ctx.set_source_rgb(0.0, 0.0, 0.35) 
    ctx.show_text( name_en )

    # finish up
    ctx.stroke() 
    surface.write_to_png(img_directory+'dlogo.png') 


run_background_map_gen()
