FROM haproxy:1.9.7-alpine

RUN apk add --update certbot curl

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy-backend.cfg /usr/local/etc/haproxy/haproxy-backend.cfg
COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /etc/letsencrypt

CMD ["/start.sh"]
