FROM jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

USER root
RUN apt-get update && apt-get install -yq \
  php5-mysql \
  php5-gd \
  php5-curl \
  php-pear

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

USER jenkins

RUN composer global require "phpunit/phpunit=4.6.*" --prefer-source --no-interaction && \
composer global require "squizlabs/php_codesniffer=1.4.*" --prefer-source --no-interaction && \
composer global require "phploc/phploc=2.0.*" --prefer-source --no-interaction && \
composer global require "phpmd/phpmd=1.5.*" --prefer-source --no-interaction && \
composer global require "drush/drush=dev-master" --prefer-source --no-interaction
