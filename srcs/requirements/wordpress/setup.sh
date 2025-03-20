#!/bin/bash
cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

DB_USER_PASSWORD=${cat /run/secrets/db_user_password}

./wp-cli.phar core download --allow-root
./wp-cli.phar config create --dbname=wordpress --dbuser=wp_user --dbpass=${DB_USER_PASSWORD} --dbhost=inception_mariadb --allow-root
./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
./wp-cli.phar user create editor editor@editor.com --role=editor --user_pass=editorpassword --allow-root

php-fpm8.2 -F
