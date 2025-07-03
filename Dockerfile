FROM osrm/osrm-backend

WORKDIR /data

# Renombramos para que la salida de osrm-extract sea "map.osrm"
COPY cordoba-latest.osm.pbf map.osm.pbf

RUN osrm-extract -p /opt/car.lua map.osm.pbf && \
    osrm-partition map.osrm && \
    osrm-customize map.osrm

CMD ["osrm-routed", "--algorithm", "mld", "map.osrm"]