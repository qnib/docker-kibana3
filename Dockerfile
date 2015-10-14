FROM qnib/terminal:fd22

## nginx
RUN dnf install -y nginx httpd-tools
ADD etc/nginx/ /etc/nginx/
ADD etc/diamond/collectors/NginxCollector.conf /etc/diamond/collectors/NginxCollector.conf
ADD etc/supervisord.d/nginx.ini /etc/supervisord.d/
ADD etc/consul.d/ /etc/consul.d/
ADD opt/qnib/bin/start_nginx.sh /opt/qnib/bin/


## Kibana
ENV KIBANA_VER 3.1.2
WORKDIR /var/www/
RUN curl -s -o /opt/kibana-${KIBANA_VER}.tar.gz https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VER}.tar.gz && \
    tar xf /opt/kibana-${KIBANA_VER}.tar.gz && rm -f /opt/kibana-${KIBANA_VER}.tar.gz && \
    mv /var/www/kibana-${KIBANA_VER} /var/www/kibana/

ADD etc/nginx/conf.d/kibana.conf /etc/nginx/conf.d/kibana.conf

# Config kibana-Dashboards
ADD var/www/kibana/app/dashboards/ /var/www/kibana/app/dashboards/
ADD var/www/kibana/config.js /var/www/kibana/config.js

