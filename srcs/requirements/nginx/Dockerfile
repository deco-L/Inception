FROM debian:bookworm

ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV HTTP_PROXY=${HTTP_PROXY}
ENV http_proxy=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV https_proxy=${HTTPS_PROXY}

RUN apt update && \
  apt install -y nginx

COPY ./conf/default /etc/nginx/sites-available/.
CMD ["nginx", "-g", "daemon off;"]
