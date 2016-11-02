FROM debian:jessie 
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
       osmctools \
       mc \
    && rm -rf /var/lib/apt/lists/

### install imposm3  ( need for setup )
RUN mkdir /tools \
    && cd /tools \
    && wget http://imposm.org/static/rel/imposm3-0.2.0dev-20161012-ee59cf2-linux-x86-64.tar.gz \
    && tar zxvf imposm3-0.2.0dev-20161012-ee59cf2-linux-x86-64.tar.gz \
    && ln -s imposm3-0.2.0dev-20161012-ee59cf2-linux-x86-64 latest

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