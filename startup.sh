set -e

if [[ ! -f /srv/cert/fullchain.pem ]] || [[ ! -f /srv/cert/privkey.pem ]]
then
  if [[ -f /srv/cert/fullchain.pem ]]
  then
    rm /srv/cert/fullchain.pem
  fi

  if [[ -f /srv/cert/privkey.pem ]]
  then
    rm /srv/cert/privkey.pem
  fi


  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /srv/cert/privkey.pem \
    -out /srv/cert/fullchain.pem -outform PEM \
    -subj "/C=DE/ST=Berlin/L=Berlin/O=Some Company/OU=IT Department/CN=example.com"
fi

nginx
php-fpm7

while [[ 1 ]]
do
  :
done
