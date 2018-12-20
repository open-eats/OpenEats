# Using a certbot container to set up HTTPS

*The following procedure is taken from [this page](https://github.com/wmnnd/nginx-certbot) and modified to work with OpenEats.*

This will set up a certbot container to automatically get and renew a SSL certificate by LetsEncrypt.

### Changes to `docker-prod.override.yml`

Add volumes, the 443 port and the certbot container to your `docker-prod.override.yml`.

```
version: '2.3'
services:
  nginx:
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./data/nginx:/etc/nginx/conf.d
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
    restart: always
  certbot:
    image: certbot/certbot
    volumes:
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
  api:
    restart: always
  web:
    restart: on-failure
  db:
    restart: always
```

#### Automatic renewal

If you wish to auto renew the certificates add the line
`command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"`
to the nginx part and the line
`entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"`
to the certbot part.
This will check if the certificate is up for renewal every 12 hours and reload the nginx config every 6 hours.


### Changes to default.conf of nginx

To allow easier access to the `default.conf` the former step changed the path of the `conf.d` path to outside of the nginx container. To still work the `default.conf` has to be in `/data/nginx/`.

For that first create the path.

``` 
cd OpenEats
mkdir -p data/nginx
```

Then copy the default.conf out of the container to that path.

`docker cp openeats_nginx_1:/etc/nginx/conf.d/default.conf data/nginx/default.conf`

Now change this file to redirect all HTTP to HTTPS and set up the HTTPS settings. Furthermore add the path for the certbot verification by webroot.

*Remember to change the \<domain.org\> to your domain.*

```
upstream api {
  ip_hash;
  server api:80;
}

server {
    listen 80;
    server_name localhost;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name localhost;

    
    ssl_certificate /etc/letsencrypt/live/<domain.org>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<domain.org>/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        root /var/www/html/openeats-static/public-ui;
        try_files $uri $uri/ /index.html;
    }

    location /static/  {
        root /var/www/html/openeats-static/public-ui;
        gzip on;
        gzip_types text/plain text/xml text/css
            text/comma-separated-values
            text/javascript application/x-javascript
            application/javascript
            application/atom+xml;

        expires max;
    }

    location /api/ {
        proxy_pass http://api;
        proxy_set_header Host $http_host;
    }

    location /admin/ {
        proxy_pass http://api;
        proxy_set_header Host $http_host;
    }

    location /static-files/ {
        root /var/www/html/openeats-static;
        try_files $uri /static-files/$uri;
    }

    location /site-media/ {
        root /var/www/html/openeats-static;
        try_files $uri /site-media/$uri;
    }
}
```

### Set up and run`init-letsencrypt.sh`

Download the script to set it all up.

`curl -L https://raw.githubusercontent.com/unimariJo/nginx-certbot/master/init-letsencrypt.sh > init-letsencrypt.sh`

This script will create a dummy certificate to start nginx, then certbot will verify and get the the valid certificate. 

For this, add your domain and email to this script. However, **every instance of** `docker-compose` **in that script has to be changed to** `docker-compose -f docker-prod.yml -f docker-prod.version.yml -f docker-prod.override.yml` **to load the correct files.**

After that the script can be run.

```
chmod +x ./init-letsencrypt.sh
sudo ./init-letsencrypt.sh
``` 

### Change the `env_prod.list`

Lastly, change the `NODE_API_URL` in `env_prod.list` to use HTTPS instead of HTTP to avoid mixed content and restart the nginx container.

`docker restart openeats_nginx_1`


