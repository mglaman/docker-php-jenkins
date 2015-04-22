FROM jenkins

RUN wget http://localhost:8080/jnlpJars/jenkins-cli.jar
RUN java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations warnings xunit
RUN java -jar jenkins-cli.jar -s http://localhost:8080 safe-restart

USER root
RUN apt-get update && apt-get install -yq mysql-server php5-mysql php5-gd php5-curl php-pear
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require "phpunit/phpunit=4.6.*"
RUN composer global require "squizlabs/php_codesniffer=1.4.*"
RUN composer global require "phploc/phploc=2.0.*"
RUN composer global require "phpmd/phpmd=1.5.*"
RUN composer global require "phing/phing=2.6.*"

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

EXPOSE 80 3306
USER jenkins
