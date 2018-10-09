# docker-grav-fpm

A Docker container for serving up a Grav site using php-fpm

This sets up a bare-bones, no frills [Grav](https://getgrav.org) site using php-fpm 7.1+

Since this image is based upon the official `php-fpm` Docker image build from [PHP](https://hub.docker.com/_/php/), these images get updated within minutes of those source images getting updated.

## Supported tags and respective `Dockerfile` links

`7.2`, `latest` [(v7.2/php/Dockerfile)](https://github.com/ericpoe/docker-grav-fpm/blob/v7.2/php/Dockerfile)
`7.1` [(v7.1/php/Dockerfile)](https://github.com/ericpoe/docker-grav-fpm/blob/v7.1/php/Dockerfile)

## How to use this image

### Docker-Compose

For a bare-bones setup of a Grav site:

* Checkout the repo for this container, [ericpoe/docker-grav-fpm](https://github.com/ericpoe/docker-grav-fpm)
* Run `docker-compose up`
* http://localhost:8000

#### Suppose you want more than just the default site and default content

You could map your dev `user` directory to the dockerized user directory.

```yaml
version: '3'

services:
    web:
        image: nginx:latest
        ports:
            - "8000:80"
        volumes:
            - ./site.conf:/etc/nginx/conf.d/default.template
            - web-volume:/var/www/html
            - ./src/user/:/var/www/html/user ## <-- Here
        environment:
            - NGINX_HOST=${NGINX_HOST}
        command: /bin/sh -c "envsubst '$$NGINX_HOST' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
        depends_on:
            - php
    php:
        image: ericpoe/grav-fpm:latest
        volumes:
            - web-volume:/var/www/html
            - ./src/user/:/var/www/html/user ## <-- Here
volumes:
    web-volume:
```

## Comments and Pull Requests Welcome

If you find a bug or want to make a pull request, please do so at this image's [Github repository](https://github.com/ericpoe/docker-grav-fpm).

Feel free to reach out to me via Twitter: [@eric_poe](https://twitter.com/eric_poe)