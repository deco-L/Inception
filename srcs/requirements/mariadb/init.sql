CREATE DATABASE wordpress;

-- CREATE USER wp_root@'%' IDENTIFIED BY 'wp_root_password';
-- GRANT ALL PRIVILEGES ON wordpress.* TO wp_root@'%' WITH GRANT OPTION;

CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_user_password';
GRANT ALL PRIVILEGES ON *.* TO 'wp_user'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
