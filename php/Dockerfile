FROM php:7.3-fpm as ecosystem_php

LABEL maintainer="Matthieu CONTET <matt.contet@icloud.com>"

# Install basic requirements
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        autoconf \
        bzip2 \
        cron \
        curl \
        dnsutils \
        gnupg \
        jpegoptim \
        jq \
        libcurl4-openssl-dev \
        libicu-dev \
        libfreetype6-dev \
        libgpgme11-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libssh2-1-dev \
        libssl-dev \
        libwebp-dev \
        libxml2-dev \
        libxml2-utils \
        libxslt-dev \
        libzip-dev \
        logrotate \
        mailutils \
        mariadb-client \
        moreutils \
        openssl \
        p7zip-full \
        postgresql \
        postgresql-contrib \
        procps \
        msmtp \
        npm \
        unzip \
        wget \
        zip && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-gd \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-webp-dir=/usr/include/ && \
    docker-php-ext-configure zip \
        --with-libzip && \
    docker-php-ext-install \
        bcmath \
        gd \
        iconv \
        intl \
        mbstring \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        soap \
        xml \
        xsl \
        zip && \
    perl -pi -e "s|;pm.status_path = /status|pm.status_path = /php_fpm_status|g" /usr/local/etc/php-fpm.d/www.conf && \
    rm -rf /var/lib/apt/lists/*

# Install Apcu, Igbinary, Imagick, Redis and ssh2
RUN pecl install apcu igbinary redis && \
    docker-php-ext-enable apcu igbinary redis

# Install GMP
RUN apt-get update -y && \
	apt-get install -y libgmp-dev re2c libmhash-dev libmcrypt-dev file && \
	ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ && \
	docker-php-ext-configure gmp && \
	docker-php-ext-install gmp

# Install Composer globally
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer config --global repos.packagist composer https://repo.packagist.org && \
    composer global config minimum-stability alpha && \
    composer global require "hirak/prestissimo" "sensiolabs-de/deprecation-detector" --no-suggest --optimize-autoloader --classmap-authoritative
ENV PATH "${PATH}:/root/.composer/vendor/bin"

# Install Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Install yarn
RUN curl -sS https://deb.nodesource.com/setup_10.x | bash && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g grunt-cli gulp-cli && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

ADD bash_aliases /root/.bashrc

# Add crontab file in the cron directory
ADD custom_crontab /var/spool/cron/crontabs/root

RUN usermod -u 1000 www-data

# Install custom entrypoint
COPY entrypoint.sh /usr/local/bin/docker-custom-entrypoint
RUN chmod 777 /usr/local/bin/docker-custom-entrypoint
CMD ["php-fpm"]
ENTRYPOINT ["docker-custom-entrypoint"]