FROM debian:bookworm

RUN apt update && \
apt install -y mariadb-server
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./init.sql /etc/mysql/init.sql
COPY init_database.sh .
RUN mkdir /run/mysqld && chmod +x init_database.sh
CMD ["./init_database.sh"]
