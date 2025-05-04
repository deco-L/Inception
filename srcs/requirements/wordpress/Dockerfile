FROM debian:oldstable

ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV HTTP_PROXY=${HTTP_PROXY}
ENV http_proxy=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV https_proxy=${HTTPS_PROXY}

RUN set -eux; \
    apt-get update && \
    apt-get install -y php-fpm \
    php-mysqli \
    curl

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d
COPY ./docker-entrypoint.sh /usr/local/bin/

RUN mkdir -p /run/php

WORKDIR /app

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["docker-entrypoint.sh"]
