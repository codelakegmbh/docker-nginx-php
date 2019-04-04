FROM alpine:latest

RUN mkdir /srv/http
RUN mkdir /srv/cert
WORKDIR /srv/http

COPY startup.sh /root/startup.sh
COPY 01proxy_pass.conf /etc/nginx/conf.d/01proxy_pass.conf

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN apk --update add ca-certificates
RUN echo "@php https://php.codecasts.rocks/v3.8/php-7.3" >> /etc/apk/repositories

RUN apk update
RUN apk add \
  php \
  php-fpm \
  php-mysqli \
  php-mbstring \
  php-xml \
  php-zip \
  nginx

RUN rm /etc/nginx/conf.d/default.conf

RUN mkdir /run/nginx

EXPOSE 443

CMD ["/bin/sh", "/root/startup.sh"]
