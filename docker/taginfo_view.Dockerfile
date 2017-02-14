FROM alpine:3.5

RUN apk update \
    && apk upgrade \
    && apk add -U --no-cache --virtual .build-dependencies \ 
         build-base \
         ca-certificates \
         git \
         mc \
         ruby \
         ruby-dev \
         sqlite-dev \
    && gem install json_pure     --clear-sources --no-document \
    && gem install rack          --clear-sources --no-document \
    && gem install rack-contrib  --clear-sources --no-document \
    && gem install rake          --clear-sources --no-document \
    && gem install sinatra       --clear-sources --no-document \
    && gem install sinatra-r18n  --clear-sources --no-document \
    && gem install sqlite3       --clear-sources --no-document \
    && gem cleanup \
    && gem list \
    # install apps 
    && mkdir -p /osm/taginfo/ \
    && git clone  --quiet --depth 1 https://github.com/taginfo/taginfo.git /osm/taginfo \
    # remove some files - not needed for web view... 
    && rm -rf /osm/taginfo/bin \
    && rm -rf /osm/taginfo/examples \
    && rm -rf /osm/taginfo/sources \
    && rm -rf /osm/taginfo/tagstats \
    # remove caches
    && rm -rf /var/cache/apk/* /tmp/* \
    # remove taginfo logo for symbolic links!  
    && rm -f /osm/taginfo/web/public/img/logo/taginfo.png 

WORKDIR /osm
CMD /osm/sh/startweb.sh
