FROM haproxy:1.9.7-alpine

RUN apk update && apk add openssl

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy-backend.cfg /usr/local/etc/haproxy/haproxy-backend.cfg
COPY gen.conf .

RUN openssl genrsa -out key.pem && \
  openssl req -new -config gen.conf -key key.pem -out csr.pem && \
  openssl x509 -req -days 9999 -in csr.pem -signkey key.pem -out cert.pem && \
  rm csr.pem && \
  cp cert.pem https_cert.pem && \
  cat key.pem >> https_cert.pem && \
  rm cert.pem key.pem && \
  mv https_cert.pem /etc/ssl/private/

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg", "-f", "/usr/local/etc/haproxy/haproxy-backend.cfg"]
