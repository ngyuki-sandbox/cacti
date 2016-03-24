# Cacti

*docker-compose.yml*

```
version: '2'

services:

  cacti:
    build: ./
    image: ngyuki/cacti
    environment:
      MYSQL_HOST: mysql
      MYSQL_PORT: "3306"
      MYSQL_DATABASE: cacti
      MYSQL_USER: cactiuser
      MYSQL_PASSWORD: cactisecret
      TZ: Asia/Tokyo
    ports:
      - "8080:80"
    volumes:
      - ~/work/cacti/log:/var/www/html/log
      - ~/work/cacti/rra:/var/www/html/rra

  mysql:
    image: mysql
    command:
      - --character-set-server=utf8
      - --sql-mode=
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: 1
      MYSQL_DATABASE: cacti
      MYSQL_USER: cactiuser
      MYSQL_PASSWORD: cactisecret
      TZ: Asia/Tokyo
    volumes:
      - ~/work/cacti/mysql:/var/lib/mysql
```

## TODO

- テンプレートをインポートする機能を付けたい
  - cacti-startup.sh で下記のように処理
    - import `/etc/cacti/templates/`
    - copy `/etc/cacti/scripts/` to `/var/www/html/scripts/`
