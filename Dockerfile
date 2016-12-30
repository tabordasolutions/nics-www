FROM debian:jessie

RUN apt-get update && \
  apt-get install -y apache2 && \
  rm -rf /var/lib/apt/lists/*

# Install and config OpenAM agent

COPY nics.conf /etc/apache2/sites-available/

RUN a2dissite 000-default
RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel
RUN a2enmod headers
RUN a2ensite nics

EXPOSE 80
EXPOSE 443

CMD ["apache2ctl", "-D", "FOREGROUND"]

VOLUME /var/www/html/static
