FROM debian:bookworm

ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV HTTP_PROXY=${HTTP_PROXY}
ENV http_proxy=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV https_proxy=${HTTPS_PROXY}

RUN groupadd --gid 999 -r mysql && \
    useradd -r -g mysql mysql --home-dir /var/lib/mysql --uid 999

RUN set -eux; \
    apt-get update; \
    apt-get install -y mariadb-server; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN set -eux; \
    mkdir -p /run/mysqld; \
    chown mysql:mysql /run/mysqld; \
    chmod 1777 /run/mysqld

USER mysql

ENTRYPOINT ["docker-entrypoint.sh"]
