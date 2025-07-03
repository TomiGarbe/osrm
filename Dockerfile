FROM osrm/osrm-backend

WORKDIR /data

COPY cordoba-latest.osm.pbf /data/

RUN osrm-extract -p /opt/car.lua /data/cordoba-latest.osm.pbf && \
    osrm-partition /data/cordoba-latest.osm.pbf.osrm && \
    osrm-customize /data/cordoba-latest.osm.pbf.osrm

CMD ["osrm-routed", "--algorithm", "mld", "/data/cordoba-latest.osm.pbf.osrm"]