FROM drupal:8-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
  ssl-cert \
	curl \
	git \
	mariadb-client \
	vim \
	zip \
	unzip \
	wget

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');" && \
	wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.4.2/drush.phar && \
	chmod +x drush.phar && \
	mv drush.phar /usr/local/bin/drush && \
	rm -rf /var/www/html/* && \
  rm -r /var/lib/apt/lists/* && \
  a2enmod ssl && \
  a2ensite default-ssl && \
  sed -i "s/^[ \t]*DocumentRoot \/var\/www\/html$/DocumentRoot \/var\/www\/html\/web/" /etc/apache2/sites-enabled/default-ssl.conf


COPY apache-drupal.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/html/web
