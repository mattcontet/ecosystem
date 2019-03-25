# Docker Environment
This repository allows the creation of a Docker environment to work locally, based on nginx

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Installation
This process assumes that [Docker Engine](https://www.docker.com/docker-engine) and [Docker Compose](https://docs.docker.com/compose/) are installed.
Otherwise, you should have a look to [Install Docker Engine](https://docs.docker.com/engine/installation/) before proceeding further.

:bangbang: You also need the `make` linux package.

### Clone the repository
```bash
$ git clone git@github.com:mattcontet/ecosystem.git ecosystem
```
It's also possible to download it as a [ZIP archive](https://github.com/mattcontet/ecosystem/archive/master.zip).

### Set up the environment
```bash
$ make setup
```

### Build the environment
```bash
$ make install
```

### Check the containers
```bash
docker-compose ps
          Name                         Command               State                       Ports
-------------------------------------------------------------------------------------------------------------------
ecosystem_elasticsearch_1   /usr/local/bin/docker-entr ...   Up      0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
ecosystem_maildev_1         bin/maildev --web 80 --smtp 25   Up      25/tcp, 0.0.0.0:1080->80/tcp
ecosystem_mysql_1           docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp
ecosystem_nginx_1           nginx -g daemon off;             Up      0.0.0.0:80->80/tcp
ecosystem_php_1             docker-php-entrypoint php-fpm    Up      9000/tcp
ecosystem_redis_1           docker-entrypoint.sh redis ...   Up      0.0.0.0:6379->6379/tcp
```