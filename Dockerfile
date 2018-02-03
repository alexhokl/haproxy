FROM haproxy:1.8.3-alpine

RUN apk add --update certbot curl

COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /etc/letsencrypt

CMD ["/start.sh"]
