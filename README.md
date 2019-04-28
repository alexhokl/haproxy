#### Usage

There are two major usages of this image.

1. If the setup has just one container behind this reverse proxy, the current
   image works out-of-the-box once the required environment variables are set
   correctly.
2. If the setup has more than just one container or things like ACL has to be
   configured, this image can be used used to build the customised image the
   setup required.

##### Simple one container backend

The usage can be demonstrated by this Docker Compose file where there are only
two containers; HAProxy and Nginx; and SSL termination is done at HAProxy
before the traffic goes into Nginx.

```yml
version: "3.5"

services:
  web:
    image: nginx
  reverse-proxy:
    image: alexhokl/haproxy:latest
    environment:
      STATS_USERNAME: stats_admin
      STATS_PASSWORD: AVeryStrongPassword
      DESTINATION_CONTAINER: web
      DESTINATION_CONTAINER_PORT: 80
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - web
```

##### Customised backend configuration

Create a docker file and a configuration file `haproxy-backend.cfg`.

###### haproxy-backend.cfg

```cfg
backend nginx
  balance roundrobin
  server web "${DESTINATION_CONTAINER}":"${DESTINATION_CONTAINER_PORT}" maxconn 32
```

Currently, the name `nginx` cannot be changed. Customisations can be done by
adding more blocks and/or modifying block `backend nginx`.

###### Dockerfile

```Dockerfile
FROM alexhokl/haproxy:latest

COPY haproxy-backend.cfg /usr/local/etc/haproxy/haproxy-backend.cfg
```

#### Tags

##### latest

This contains Let's Encrypt Certbot to create true SSL certificates. This
should be used for production.

##### dev

This contains a self-generated certificate. This should be used for development
purpose.

#### Build

```sh
docker build -t alexhokl/haproxy:dev /dev
docker build -t alexhokl/haproxy:latest .
```

