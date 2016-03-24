<?php
$database_type = "mysql";
$database_default = getenv('MYSQL_DATABASE');
$database_hostname = getenv('MYSQL_HOST');
$database_username = getenv('MYSQL_USER');
$database_password = getenv('MYSQL_PASSWORD');
$database_port = getenv('MYSQL_PORT');
$database_ssl = false;

$url_path = "/";

if (getenv('TZ') !== false) {
    date_default_timezone_set(getenv('TZ'));
}
