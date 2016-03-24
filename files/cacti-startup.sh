#!/bin/bash

mysql() {
  MYSQL_PWD=$MYSQL_PASSWORD \
    command mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" "$MYSQL_DATABASE" "$@"
}

echo "wait for mysql"

while ! mysqladmin -h "$MYSQL_HOST" -P "$MYSQL_PORT" ping 2> /dev/null; do
  sleep 1
done

if ! mysql -e "show tables" | grep . >/dev/null; then
  echo "import cacti tables"
  mysql < /var/www/html/cacti.sql
fi

echo "create cacti directory"
chown -R www-data /var/www/html/log
chown -R www-data /var/www/html/rra

echo "create cacti log file"
touch /var/www/html/log/cacti.log
chown www-data /var/www/html/log/cacti.log

echo "create apache service"
mkdir -p /service/apache/
cat <<'EOS'> /service/apache/run
#!/bin/bash
exec apache2-foreground
EOS
chmod +x /service/apache/run

echo "create cron service"
mkdir -p /service/cron/
cat <<'EOS'> /service/cron/run
#!/bin/bash
exec chpst -u www-data go-cron "0 */5 * * * *" php /var/www/html/poller.php
EOS
chmod +x /service/cron/run

echo "exec runsvdir /service"
exec runsvdir /service
