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
        git \
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
        libssh2-1-dev \
        libssl-dev \
        libxml2-dev \
        libxml2-utils \
        libxslt-dev \
        libzip-dev \
        mailutils \
        moreutils \
        mysql-client \
        nano \
        net-tools \
        netcat \
        openssl \
        p7zip-full \
        procps \
        ssh-client \
        ssmtp \
        unzip \
        vim \
        wget \
        zip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install \
        bcmath \
        gd \
        iconv \
        intl \
        mbstring \
        opcache \
        pdo_mysql \
        soap \
        xml \
        xsl \
        zip && \
    perl -pi -e "s/mailhub=mail/mailhub=maildev/" /etc/ssmtp/ssmtp.conf && \
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
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV PATH "${PATH}:/root/.composer/vendor/bin"

# Install Node.js & co
RUN curl -sS https://deb.nodesource.com/setup_10.x | bash && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g grunt-cli gulp-cli && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

ADD bash_aliases /root/.bashrc

RUN usermod -u 1000 www-data
