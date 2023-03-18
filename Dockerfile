FROM alpine:3.16.4
LABEL org.opencontainers.image.authors="stefan.golinschi@gmail.com"

# Install required packages
RUN apk update && apk add wget build-base

# Install BerkeleyDB
ENV BERKELEYDB_RELEASE "4.7.25"
RUN mkdir -p /openldap-builder && \
    cd /openldap-builder && \
    wget http://ftpmirror.your.org/pub/misc/Berkeley-DB/db-${BERKELEYDB_RELEASE}.zip && \
    unzip db-${BERKELEYDB_RELEASE}.zip && \
    cd db-${BERKELEYDB_RELEASE} && \
    cd build_unix && ../dist/configure --prefix=/usr && make -j$(nproc) && make install

# Install OpenLDAP
ENV OPENLDAP_RELEASE "2_3_27"
RUN mkdir -p /openldap-builder && \
    cd /openldap-builder && \
    wget https://github.com/openldap/openldap/archive/refs/tags/OPENLDAP_REL_ENG_${OPENLDAP_RELEASE}.tar.gz && \
    tar -xzf OPENLDAP_REL_ENG_${OPENLDAP_RELEASE}.tar.gz && \
    cd openldap-OPENLDAP_REL_ENG_${OPENLDAP_RELEASE} && \
    ./configure && CPPFLAGS=-D_GNU_SOURCE make -j$(nproc) && make install

# Install entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
