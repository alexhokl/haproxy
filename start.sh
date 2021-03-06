certbot certonly \
  --standalone --text --agree-tos \
  --no-self-upgrade \
  --keep-until-expiring --non-interactive --email "$EMAIL" -d "$DOMAINS" \
  || exit 1

mkdir -p /usr/local/etc/haproxy/certs
for site in `find /etc/letsencrypt/live/ -type d -exec basename {} \; | grep -v live`; do
    cat /etc/letsencrypt/live/$site/privkey.pem \
      /etc/letsencrypt/live/$site/fullchain.pem \
      | tee /usr/local/etc/haproxy/certs/haproxy-"$site".pem >/dev/null
done

haproxy -f /usr/local/etc/haproxy/haproxy.cfg -f /usr/local/etc/haproxy/haproxy-backend.cfg
