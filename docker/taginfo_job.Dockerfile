FROM debian:testing 
### Docker for : taginfo-job +  setup 

### For the Taginfo JOB
RUN apt-get update \ 
    && apt-get install  -y --no-install-recommends \
       # basic tools
       build-essential \
       ca-certificates \
       curl \
       git \
       wget \
       # need for taginfo 
       libbz2-dev \
       libicu-dev \
       pbzip2 \
       # need for taginfo
       libsqlite3-dev \
       m4 \
       ruby \ 
       ruby-dev \
       sqlite3 \
       # need for taginfo-libosmium
       libboost-dev \
       libexpat1-dev \
       libgd2-xpm-dev \
       libgeos-dev \
       libgeos++-dev \
       libosmpbf-dev \
       libprotobuf-dev \
       libsparsehash-dev \
       zlib1g-dev \
    && rm -rf /var/lib/apt/lists/

RUN gem install --clear-sources --no-document \ 
       json \
       rack-contrib \
       sinatra \
       sinatra-r18n \
       sqlite3 \
    && gem list 

### for 'setup' - python geos req 
RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
       libcurl4-gnutls-dev \
       libgdal-dev \
       libgeos-dev \
       libpq-dev \
       libproj-dev \
       libxml2-dev \
       libxslt-dev \ 
       postgresql-client \
       # python tools 
       mapnik-utils \
       python \
       python-dev \
       python-jinja2 \
       python-mapnik \
       python-psycopg2 \
       python-yaml \
    && rm -rf /var/lib/apt/lists/

### install tools ( osmctools - for OSM filtering!  mc: for debugging)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       osmium-tool \
       mc \
       unzip \
    && rm -rf /var/lib/apt/lists/

### install imposm3  ( need for setup )
ENV IMPOSM3VER imposm3-0.3.0dev-20170119-353bc5d-linux-x86-64
RUN mkdir /tools \
    && cd /tools \
    && wget http://imposm.org/static/rel/${IMPOSM3VER}.tar.gz \
    && tar zxvf ${IMPOSM3VER}.tar.gz \
    && ln -s ${IMPOSM3VER} latest

# install  julien-noblet/download-geofabrik
RUN cd /tools \
    && wget https://github.com/julien-noblet/download-geofabrik/releases/download/v2.0.0/download-geofabrik-android_amd64.zip \
    && unzip download-geofabrik-android_amd64.zip \
    && rm download-geofabrik-android_amd64.zip 

### install taginfo
RUN    mkdir -p /osm/taginfo/ \
    && mkdir -p /osmcode/libosmium \
    && git clone  --quiet --depth 1 https://github.com/osmcode/libosmium /osmcode/libosmium \
    && cd /osmcode/libosmium &&  git log > /osm/gitlog_libosmium.txt \
    && git clone  --quiet --depth 1 https://github.com/taginfo/taginfo.git /osm/taginfo \
    && cd /osm/taginfo && git log > /osm/gitlog_taginfo.txt \ 
    # remove taginfo logo for a synbolic link 
    && rm -f /osm/taginfo/web/public/img/logo/taginfo.png 

WORKDIR /osm
