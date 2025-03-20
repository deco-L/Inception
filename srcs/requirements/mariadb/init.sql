CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'wp_root'@'%' IDENTIFIED BY '/run/secrets/db_root_password';
CREATE USER 'wp_user'@'%' IDENTIFIED BY '/run/secrets/db_user_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_root'@'%' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON wordpress.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;