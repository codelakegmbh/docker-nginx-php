FROM alpine:latest

RUN mkdir /srv/http
RUN mkdir /srv/cert
WORKDIR /srv/http

COPY startup.sh /root/startup.sh
COPY 01proxy_pass.conf /etc/nginx/conf.d/01proxy_pass.conf

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
EXPOSE 80

CMD ["/bin/sh", "/root/startup.sh"]
