FROM debian:bookworm

RUN apt-get update
RUN apt-get install -y nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf