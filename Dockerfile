FROM osrm/osrm-backend

WORKDIR /data

# Descarga el PBF directo
RUN curl -O https://download.openstreetmap.fr/extracts/south-america/argentina/cordoba-latest.osm.pbf

# Procesado de OSRM
RUN osrm-extract -p /opt/car.lua /data/cordoba-latest.osm.pbf && \
    osrm-partition /data/cordoba-latest.osm.osrm && \
    osrm-customize /data/cordoba-latest.osm.osrm

# Arranque del servicio
CMD ["osrm-routed", "--algorithm", "mld", "/data/cordoba-latest.osm.osrm"]