FROM redis:latest

LABEL maintainer="Matthieu CONTET <matt.contet@icloud.com>"

# Install custom Redis configuration
COPY redis.conf /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
