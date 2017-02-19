FROM debian:jessie

RUN apt-get update && \
  apt-get install -y apache2 openjdk-7-jre unzip && \
  rm -rf /var/lib/apt/lists/*

COPY web-policy-agent.zip /opt
RUN cd /opt && \
  unzip web-policy-agent && \
  mkdir -p forgerock && \
  mv web_agents forgerock/openam-web-policy-agent-3.3.4 && \
  rm /opt/web-policy-agent.zip
COPY pass.txt /root
RUN chmod 0600 /root/pass.txt
COPY responses.txt /root/
RUN cd /etc/apache2 && ln -sf apache2.conf httpd.conf

COPY nics.conf /etc/apache2/sites-available/

RUN a2dissite 000-default
RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel
RUN a2enmod headers
RUN a2ensite nics

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT /docker-entrypoint.sh

EXPOSE 80
EXPOSE 443

