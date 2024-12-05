FROM debian:bookworm

RUN apt update && \
apt install -y php-fpm \
php-mysqli \
curl
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d
WORKDIR /app
COPY ./setup.sh .
RUN chmod +x ./setup.sh
CMD ["./setup.sh"]
