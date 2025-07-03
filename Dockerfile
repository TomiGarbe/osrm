FROM osrm/osrm-backend

WORKDIR /data

COPY cordoba-latest.osm.pbf /data/

RUN osrm-extract -p /opt/car.lua cordoba-latest.osm.pbf && \
    osrm-partition cordoba-latest.osm.pbf.osrm && \
    osrm-customize cordoba-latest.osm.pbf.osrm

CMD ["osrm-routed", "--algorithm", "mld", "cordoba-latest.osm.pbf.osrm"]
