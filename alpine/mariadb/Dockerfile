FROM nginx:1.14.2-alpine

#ENV NODE_API_URL http://my.domain.com
#ENV ALLOWED_HOST my.domain.com
#ENV DJANGO_SECRET_KEY sdfsadfas32e98zsdvhhsnz6udvbksjdhfi4galshjfg
ENV OPENEATS_VERSION 1.4.0

ENV PATH /usr/local/bin:$PATH

# nginx config
ENV API_HOST 0.0.0.0
ENV API_PORT 8000

# Database config
ENV MYSQL_HOST openeats-mariadb
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE openeats
ENV MYSQL_USER openeats
ENV MYSQL_ROOT_PASSWORD openeats

# Django config
ENV API_URL 0.0.0.0:8000
ENV DJANGO_SETTINGS_MODULE base.settings
ENV DJANGO_DEBUG False
ENV HTTP_X_FORWARDED_PROTO true

# Node config
ENV NODE_ENV production
ENV NODE_URL localhost:8080
ENV NODE_LOCALE en

RUN apk add --update-cache --update \
        # fetch deps
        ca-certificates tar openssl \
        # node deps
        yarn \
        # api deps
        mariadb-dev \
        python3 \
        jpeg-dev \
        zlib-dev \
        freetype-dev \
        lcms2-dev \
        openjpeg-dev \
        tiff-dev \
        tk-dev \
        tcl-dev \
        gcc \
        python3-dev \
        musl-dev && \
    cd /tmp && \
    wget -O openeats-web.tar.gz "https://github.com/open-eats/openeats-web/archive/$OPENEATS_VERSION.tar.gz" && \
    wget -O openeats-api.tar.gz "https://github.com/open-eats/openeats-api/archive/$OPENEATS_VERSION.tar.gz" && \
    tar -xzf openeats-web.tar.gz && rm openeats-web.tar.gz && mv openeats-web-$OPENEATS_VERSION /openeats-web && \
    tar -xzf openeats-api.tar.gz && rm openeats-api.tar.gz && mv openeats-api-$OPENEATS_VERSION /code && \
    apk del tar openssl && \
    chmod +x /code/base/prod-entrypoint.sh && \
    pip3 install -r /code/base/requirements.txt && \
    ln -s /usr/bin/python3 /usr/local/bin/python

RUN mkdir -p /var/www/html/openeats-static && cd /openeats-web && \
    yarn install --pure-lockfile --production=false && yarn start && \
    cp -r build/ /var/www/html/openeats-static/public-ui

#nginx
COPY default.conf /etc/nginx/conf.d/default.conf

COPY start.sh /startup/
RUN chmod +x /startup/start.sh

ENV MYSQL_PASSWORD openeats
ADD create-database.sh /scripts/create-database.sh
RUN apk add --update-cache --update mariadb mariadb-client && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

CMD ["/startup/start.sh"]
