# Content
* [About](#about)
* [Usage](#usage)
  * [Image Building](#image-building)
  * [Image Pulling](#image-pulling)
  * [Container creation](#container-creation)

## About
This image base on [alpine](https://docs.docker.com/samples/library/alpine/)
an built for PHP applications which use pretty URLs
(like you do in [Laravel](https://laravel.com/) projects).

In case your application does not rely on pretty URLs but on actual script names,
you can also run those apps in container based on this image.

## Usage

### Image building
To create containers from this image you first have to build it.
This can easily be done with the following command:
```bash
# inside the image repository folder
docker image build . -t codelake/nginx-php
```
After completion you can create containers from the image `codelake/nginx-php`.

### Image Pulling
In case you do not want to build the image yourself but pull it instead,
you can do so by using the command `docker pull codelake/nginx-php`.
For more information about the builds, please check out the
[docker hub page](https://hub.docker.com/r/codelake/nginx-php) of this repository.

### Container creation
The container exposes port `80` and `443`.
Therefore it requires SSL certificates to be present in the container folder `/srv/cert`.
In case you have to generate certificates you can do so on GNU/Linux by using the `openssl` package.
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /some/directory/privkey.pem \
  -out /some/directory/fullchain.pem -outform PEM
```
This will generate the required certificates in the needed PEM format.

Your application folder should be linked to `/srv/http`.
In case your app features an explicit `public` folder you should link you app folder to `/srv/app`
and the create a symbolic link from your app's public directory to the http directory.
The described things can be achieved with the following commands ($ = host shell; # = docker shell):
```
$ docker exec -ti <your container name> sh
# rm -r /srv/http
# ln -s /srv/app/public /srv/http
# exit
$ exit
```

So, here is a template for the container creation command:
```
docker run --name <containe-name> \
  -p <HTTP-host-port>:80 \
  -p <HTTPS-host-port>:443 \
  -v <certificate-path>:/srv/cert \
  -v <app-path>:/srv/http \
  -d codelake/nginx-php
```
