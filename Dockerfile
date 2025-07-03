FROM osrm/osrm-backend

WORKDIR /data

COPY cordoba-latest.osm.pbf /data/

# Procesado de OSRM
RUN osrm-extract -p /opt/car.lua /data/cordoba-latest.osm.pbf && \
    osrm-partition /data/cordoba-latest.osm.osrm && \
    osrm-customize /data/cordoba-latest.osm.osrm

# Arranque del servicio
CMD ["osrm-routed", "--algorithm", "mld", "/data/cordoba-latest.osm.osrm"]