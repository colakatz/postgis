FROM postgres:12
MAINTAINER Mike Dillon <mike@appropriate.io>

ENV POSTGIS_MAJOR 3
ENV POSTGIS_VERSION 3.1.1+dfsg-1.pgdg100+1
ENV PGROUTE_VERSION 3.1.0-2.pgdg100+1

RUN apt-get update \
      && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-pgrouting=$PGROUTE_VERSION \
           postgresql-$PG_MAJOR-pgrouting-scripts=$PGROUTE_VERSION \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
COPY ./update-postgis.sh /usr/local/bin
