---
---
---  imposm3 'use_single_id_space' id   to   short notations  
---
---
---
---
;;;
\set VERBOSITY terse
;;;
CREATE OR REPLACE FUNCTION imposmid2shortid (id BIGINT ) RETURNS text AS $$
BEGIN
 RETURN CASE
   WHEN  (id >=     0 )               THEN 'n'|| id::text
   WHEN  (id >= -1e17 ) AND (id < 0 ) THEN 'w'|| (abs(id))::text   
   WHEN  (id <  -1e17 )               THEN 'r'|| (abs(id) -1e17)::text   
   ELSE 'error'||id::text
  END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

--  imposm3 'use_single_id_space' id   to   osm URL 
CREATE OR REPLACE FUNCTION imposmid2weburl (id BIGINT ) RETURNS text AS $$
BEGIN
 RETURN CASE
   WHEN  (id >=     0 )               THEN format('<a href="http://www.osm.org/node/%1$s">n%1$s</a>'     , id::text )
   WHEN  (id >= -1e17 ) AND (id < 0 ) THEN format('<a href="http://www.osm.org/way/%1$s">w%1$s</a>'      , (abs(id))::text )   
   WHEN  (id <  -1e17 )               THEN format('<a href="http://www.osm.org/relation/%1$s">r%1$s</a>' , (abs(id) -1e17)::text )  
   ELSE 'error_url'||id::text
  END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION get_xtaginfo(xmin  numeric, xmax  numeric, ymin  numeric, ymax numeric ) 
      RETURNS numeric[]   AS
$BODY$
DECLARE
    i  integer ;
    xs numeric ;
    ys numeric ; 
    last_ok integer ;
    xd numeric;
    yd numeric;
    zzz numeric;
    xppd numeric;
    yppd numeric;
    moda numeric[] ;
BEGIN
    moda= ARRAY [0.000,0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009
                ,0.010,0.011,0.012,0.013,0.014,0.015,0.016,0.017,0.018,0.019
                ,0.020,0.021,0.022,0.023,0.024,0.025,0.026,0.027,0.028,0.029
                ,0.030,0.031,0.032,0.033,0.034,0.035,0.036,0.037,0.038,0.039
                ,0.040,0.041,0.042,0.043,0.044,0.045,0.046,0.047,0.048,0.049
                ,0.050,0.051,0.052,0.053,0.054,0.055,0.056,0.057,0.058,0.059 
                ,0.060,0.061,0.062,0.063,0.064,0.065,0.066,0.067,0.068,0.069
                ,0.070,0.071,0.072,0.073,0.074,0.075,0.076,0.077,0.078,0.079
                ,0.080,0.081,0.082,0.083,0.084,0.085,0.086,0.087,0.088,0.089 
                ,0.09];
    last_ok =0 ;
    xd = abs(xmax-xmin);
    yd = abs(ymax-ymin); 
    -- RAISE NOTICE '         # xd=% , yd=% ', xd ,yd ;
    FOR i IN 1..30000 LOOP
        xs = i * xd ;
        ys = i * yd ;

        --RAISE NOTICE '# % , % , %', i , xs, ys ;
          --- IF ( xs * ys ) = round ( xs * ys,0 )
          ---    and xs=round(xs) 
          ---   and ys=round(ys)  THEN
          ---     -- RAISE NOTICE 'OK = % , % , %', i , xs, ys ;
          ---     last_ok = i; 
          --- END IF;  

        IF  xs * ys  > ( 255*255) THEN

        -- RAISE NOTICE '=====================';
        FOR ri IN REVERSE i..0 LOOP
        --FOR ri IN REVERSE 59..50 LOOP
           FOREACH  yppd IN ARRAY moda LOOP
             FOREACH  xppd IN ARRAY moda  LOOP
                 
                  xs=ri* (xd+   xppd ) ;
                  ys=ri* (yd+   yppd ) ; 

                     --- zzz = (xd+xppd::numeric/100) ;
                     --- RAISE NOTICE 'Z# = % ', zzz ; 
                  --RAISE NOTICE 'R# = % , % , % ,% ,%,% ,%', ri , xs, ys,  xppd, yppd , xd, yd ; 

                  IF     
                             xs=round(xs) 
                         and ys=round(ys) 
                         and (  xs * ys ) <= (255*255) 
                         THEN
                         RAISE NOTICE 'OKÉ R# = % , % , % ,% ,%', ri , xs, ys,  xppd, yppd ; 
                         --- RAISE NOTICE 'OKÉÉÉÉ = % , % , %', ri , xs, ys ;

                         RETURN  ARRAY[ round(xs) , round(ys) , xmin, xmax+xppd , ymin, ymax+yppd ] ;
                         -- RETURN last_ok ; 
                   END IF;               
             END LOOP;
           END LOOP ;
        END LOOP;   
        
         RETURN 0;
        END IF;

        
        IF  xs * ys  >= ( 255*255) 
        THEN  
           RETURN ARRAY[0,0,0,0,0,0]  ;
        END IF;   
        
    END LOOP;
       
    RETURN ARRAY[-1,0,0,0,0,0]  ;
END
$BODY$
LANGUAGE 'plpgsql' ;


--- SELECT  get_taginfo_scale(0.09,0.12) ;
Drop table IF EXISTS xtaginfo CASCADE;
create table xtaginfo as
with pdata as
(
select  name
       ,name_en
       ,lower(iso3166_1) as iso
       ,id
       ,imposmid2shortid(id) as osmid
       ,admin_level  
       ,round ( (st_xmin( st_transform(geometry, 4326) ) -  0.0051)::numeric, 2 ) as txmin
       ,round ( (st_xmax( st_transform(geometry, 4326) ) +  0.0051)::numeric, 2 ) as txmax
       ,round ( (st_ymin( st_transform(geometry, 4326) ) -  0.0051)::numeric, 2 ) as tymin
       ,round ( (st_ymax( st_transform(geometry, 4326) ) +  0.0051)::numeric, 2 ) as tymax
       ,wikidata
       ,wikipedia
       ,flag
       ,row_number() OVER ( ORDER BY lower(iso3166_1) ) as port_order 
       ,geometry
from osm_admin2 
where   admin_level =2 
        and iso3166_1 <> ''
     --  and name like  'M%'
)
, sdata as
(
Select  get_xtaginfo(txmin , txmax , tymin , tymax )  as taginfo_scale
       , * from pdata 
         --where iso ='ao'
       )

select   *
from sdata
order by iso desc;

select iso, taginfo_scale from xtaginfo ; 


 

