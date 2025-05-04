#!/bin/bash

set -eo pipefail
shopt -s nullglob

_is_sourced() {
  [ "${#FUNCNAME[@]}" -ge 2 ] \
    && [ "${FUNCNAME[0]}" = '_is_sourced' ] \
    && [ "${FUNCNAME[1]}" = 'source' ]
}

change_directory() {
  if [ ! -d "/var/www/html" ]; then
    echo "Creating /var/www/html directory..."
    mkdir -p /var/www/html
  fi
  cd /var/www/html
}

input_env() {
  if [ -f /run/secrets/db_user_password ]; then
    DB_USER_PASS=$(cat /run/secrets/db_user_password)
  fi
  if [ -f /run/secrets/wp_admin_password ]; then
    WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_password)
  fi
  if [ -f /run/secrets/wp_user_password ]; then
    WP_USER_PASS=$(cat /run/secrets/wp_user_password)
  fi
}

install_wp_cli() {
  if [ ! -f ./wp-cli.phar ]; then
    echo "Installing WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
  fi
}

initialize_wordpress() {
  if [ -f /var/www/html/wp-config.php ]; then
    echo "WordPress is already installed. Skipping installation."
    return
  fi
  ./wp-cli.phar core download --allow-root
  ./wp-cli.phar config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_USER_PASS} --dbhost=inception_mariadb --allow-root
  ./wp-cli.phar core install --url=localhost --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL} --allow-root
  ./wp-cli.phar user create ${WP_USER} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_USER_PASS} --allow-root
}

_main() {
  change_directory
  input_env
  install_wp_cli
  initialize_wordpress
  php-fpm7.4 -F
}

if ! _is_sourced; then
  _main
fi
