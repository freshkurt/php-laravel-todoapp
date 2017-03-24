FROM php:5.6.30-fpm

RUN apt-get update

RUN apt-get install libpq-dev -y \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql

RUN apt-get install -y zlib1g-dev \
  && docker-php-ext-install zip

RUN apt-get install -y  unzip git

RUN curl -sS https://getcomposer.org/installer | php \
		&& mv composer.phar /usr/local/bin/ \
		&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

RUN composer global require "laravel/installer"

ENV PATH="~/.composer/vendor/bin:${PATH}"

COPY . /app
WORKDIR /app