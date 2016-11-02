---
---
---  imposm3 'use_single_id_space' id   to   short notations  
---
---
---
---
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
    moda= ARRAY [0.01,0.02,0.03,0.04];
    last_ok =0 ;
    xd = abs(xmax-xmin);
    yd = abs(ymax-ymin); 
    RAISE NOTICE '# xd=% , yd=% ', xd ,yd ;
    FOR i IN 1..30000 LOOP
        xs = i * xd ;
        ys = i * yd ;
        --- RAISE NOTICE '# % , % , %', i , xs, ys ;
        --- IF ( xs * ys ) = round ( xs * ys,0 )
        ---    and xs=round(xs) 
        ---   and ys=round(ys)  THEN
        ---     -- RAISE NOTICE 'OK = % , % , %', i , xs, ys ;
        ---     last_ok = i; 
        --- END IF;  


        IF  xs * ys  >= ( 256*256) THEN
        FOR ri IN REVERSE i..0 LOOP
        --FOR ri IN REVERSE 59..50 LOOP
           FOREACH  yppd IN ARRAY moda LOOP
             FOREACH  xppd IN ARRAY moda  LOOP
                 
                  xs=ri* (xd+   xppd ) ;
                  ys=ri* (yd+   yppd ) ; 

                  --- zzz = (xd+xppd::numeric/100) ;
                  --- RAISE NOTICE 'Z# = % ', zzz ; 
                  --- RAISE NOTICE 'R# = % , % , % ,% ,%', ri , xs, ys,  xppd, yppd ; 
                  IF     
                             xs=round(xs) 
                         and ys=round(ys) 
                         and (  xs * ys ) <= (256*256) 
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

        
        IF  xs * ys  >= ( 256*256) 
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
       ,geometry
from osm_admin2 
where   admin_level =2 
    and iso3166_1 <> ''
     --  and name like  'M%'
)
, sdata as
(
Select  get_xtaginfo(txmin , txmax , tymin , tymax )  as taginfo_scale
       , * from pdata )

select   *
from sdata
order by iso;




 

