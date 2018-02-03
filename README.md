This Docker image should be used as a base image for creating HAProxy server
images and should not be run directly.

#### Usage

Create a docker file and a configuration file `haproxy.cfg`.

###### Dockerfile

```Dockerfile
FROM alexhokl/haproxy:latest

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
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

