FROM debian:bookworm

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

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d
COPY ./docker-entrypoint.sh /usr/local/bin/

WORKDIR /app

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["docker-entrypoint.sh"]
