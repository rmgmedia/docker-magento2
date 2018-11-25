ARG php_version=7.1
FROM php:${php_version}-fpm

LABEL maintainer="Ryan Gellis <ryan.gellis@rmgmedia.com>"

ENV COMPOSER_HOME /var/www/.composer

RUN apt-get update && apt-get install -y \
  libfreetype6-dev \
  libjpeg-dev \
  libmcrypt-dev \
  libpng-dev \
  libxml2-dev \
  libxslt-dev \
  zlib1g-dev \
  && docker-php-ext-install bcmath \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/lib \
  && docker-php-ext-install gd \
  && docker-php-ext-install intl \
  && docker-php-ext-install mcrypt \
  && docker-php-ext-install opcache \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install soap \
  && docker-php-ext-install xsl \
  && docker-php-ext-install zip \
&& rm -rf /var/lib/apt/lists/*

COPY *.sh /var/www/
RUN chown www-data:www-data /var/www/*.sh && chmod +x /var/www/*.sh

USER www-data

COPY --from=composer:1.5 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/magento

#ENTRYPOINT ["/var/www/install-magento.sh"]
