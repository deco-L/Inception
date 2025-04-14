FROM debian:bookworm

ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV HTTP_PROXY=${HTTP_PROXY}
ENV http_proxy=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV https_proxy=${HTTPS_PROXY}

RUN set -eux; \
    apt-get update; \
    apt-get install -y mariadb-server;

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./init.sql /etc/mysql/init.sql
COPY init_database.sh .

RUN mkdir /run/mysqld && chmod +x init_database.sh

ENTRYPOINT ["./init_database.sh"]
