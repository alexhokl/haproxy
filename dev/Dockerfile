FROM haproxy:1.8.3-alpine

RUN apk update && apk add openssl

COPY gen.conf .

RUN openssl genrsa -out key.pem && \
  openssl req -new -config gen.conf -key key.pem -out csr.pem && \
  openssl x509 -req -days 9999 -in csr.pem -signkey key.pem -out cert.pem && \
  rm csr.pem && \
  cp cert.pem https_cert.pem && \
  cat key.pem >> https_cert.pem && \
  rm cert.pem key.pem && \
  mv https_cert.pem /etc/ssl/private/

