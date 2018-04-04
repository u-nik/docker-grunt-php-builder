FROM dockerizr/php:5.6-cli

ENV COMPOSER_CACHE_DIR /composer-cache
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHPUNIT_VERSION 5.7.27

# Install ZIP Extension
RUN apt-get update \
    && apt-get install -y \
        git \
        libmcrypt4 \
        libmcrypt-dev \
        libcurl4-openssl-dev \
        libpng-dev \
        libpq5 \
        libpq-dev \
        libsqlite3-dev \
        libxml2-dev \
        nodejs \
        npm \
        wget \
        zip \
        zlib1g-dev \

    # Install php extensions via docker-php-ext-install script
    && docker-php-ext-install \
        bcmath \
        curl \
        gd \
        hash \
        iconv \
        json \
        mbstring \
        mcrypt \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        phar \
        shmop \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        xml \
        zip \
    && ln -s /usr/bin/nodejs /usr/bin/node \

    # Cleanup
    && apt-get remove -y \
        libmcrypt-dev \
        libcurl4-openssl-dev \
        libpng-dev \
        libpq-dev \
        libsqlite3-dev \
        libxml2-dev \
        man-db \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /usr/src/php \
    && mkdir -p /usr/src/php/ext

# Install composer
RUN	curl -sS -o composer-installer https://getcomposer.org/installer \
    && php composer-installer --install-dir=/usr/local/bin --filename=composer \
    && rm composer-installer

# Install grunt-cli
RUN npm install -g grunt-cli

# Install phpunit
RUN wget https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar \
    && mv phpunit-${PHPUNIT_VERSION}.phar /usr/local/bin/phpunit.phar

RUN mkdir /app /composer-cache /reports \
    && chmod 777 /app \
    && chmod 777 /reports \
    && chmod 777 /composer-cache

WORKDIR /app

COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY phpunit.sh /usr/local/bin/phpunit
COPY ssh/config /root/.ssh/config

RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/phpunit* \
    && rm -rf /tmp/* /var/tmp/*

VOLUME /app
VOLUME /composer-cache
VOLUME /reports

ENTRYPOINT ["docker-entrypoint.sh"]