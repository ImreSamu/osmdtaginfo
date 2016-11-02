import cairo # import the Python module
 
# setup a place to draw
surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, 258, 98)
ctx = cairo.Context (surface)
 
# paint background
#ctx.set_source_rgb(0.22, 0.08, 0.69) # blue
#ctx.rectangle(0, 0, 258, 98)
#ctx.fill()
 
# draw text

ctx.select_font_face("Courier", cairo.FONT_SLANT_NORMAL,   cairo.FONT_WEIGHT_BOLD)

ctx.set_font_size(60) # em-square height is 90 pixels
ctx.move_to(5, 60) # move to point (x, y) = (10, 90)
ctx.set_source_rgb(0.22, 0.08, 0.69) # blue
ctx.show_text('Taginfo')
 
ctx.select_font_face('Sans') 
ctx.set_font_size(20) # em-square height is 90 pixels
ctx.move_to(5, 90) # move to point (x, y) = (10, 90)
ctx.set_source_rgb(0.22, 0.08, 0.69) # blue
ctx.show_text('Nicaragua')

# finish up
ctx.stroke() # commit to surface
surface.write_to_png('/osm/export/taginfo_logo.png') # write to file