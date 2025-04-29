#!/bin/bash

set -eo pipefail
shopt -s nullglob

_is_sourced() {
  [ "${#FUNCNAME[@]}" -ge 2 ] \
    && [ "${FUNCNAME[0]}" = '_is_sourced' ] \
    && [ "${FUNCNAME[1]}" = 'source' ]
}

input_env() {
  if [ -f /run/secrets/db_admin_password ]; then
    DB_ADMIN_PASS=$(cat /run/secrets/db_admin_password)
  fi
  if [ -f /run/secrets/db_user_password ]; then
    DB_USER_PASS=$(cat /run/secrets/db_user_password)
  fi
}

initialize_db() {
  if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysqld --initialize-insecure
  fi
}

start_mysqld_no_network() {
  mysqld --socket=/run/mysqld/mysqld.sock &
  until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; do
    sleep 1
  done
}

create_db_users() {
  echo "Creating database and users..."
  mysql --protocol=SOCKET --socket=/run/mysqld/mysqld.sock <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;

CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF
}

shutdown_mysqld() {
  echo "Shutting down temporary MariaDB..."
  mysqladmin shutdown --socket=/run/mysqld/mysqld.sock
}

start_mysqld() {
  echo "Starting MariaDB for production..."
  mariadbd
  until mysqladmin ping -h inception_mariadb --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done
}

_main() {
  if [ "${1:0:1}" = '-' ]; then
    set -- mariadbd "$@"
  fi

  input_env
  initialize_db
  start_mysqld_no_network
  create_db_users
  shutdown_mysqld
  start_mysqld
}

if ! _is_sourced; then
  _main
fi
