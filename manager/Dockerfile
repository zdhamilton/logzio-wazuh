FROM ubuntu/ubuntu:latest

# Install Wazuh Manager
RUN apt-get update \
&& apt-get install curl apt-transport-https lsb-release gnupg2 -y \
&& curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - \
&& echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list \
&& apt-get update \
&& apt-get install wazuh-manager \
&& systemctl status wazuh-manager

# Install Wazuh API
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get install nodejs -y \
&& apt-get install wazuh-api -y \
&& systemctl status wazuh-api

# Install and configure Filebeat collector
RUN apt-get install curl apt-transport-https -y \
&& curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
&& echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list \
&& apt-get update \
&& apt-get install filebeat -y
&& wget https://raw.githubusercontent.com/logzio/public-certificates/master/COMODORSADomainValidationSecureServerCA.crt -P /etc/pki/tls/certs/ \
&& curl -so /etc/filebeat/wazuh-template.json https://raw.githubusercontent.com/wazuh/wazuh/v3.10.2/extensions/elasticsearch/7.x/wazuh-template.json \
&& curl -s https://packages.wazuh.com/3.x/filebeat/wazuh-filebeat-0.1.tar.gz | sudo tar -xvz -C /usr/share/filebeat/module \
&& systemctl daemon-reload \
&& systemctl enable filebeat.service

## Copy filebeat.yml config
COPY filebeat.yml /etc/filebeat/

## Start Filebeat service
RUN systemctl start filebeat \
&& systemctl status filebeat
