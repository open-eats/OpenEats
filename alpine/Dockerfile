FROM nginx:1.14.2-alpine

#ENV NODE_API_URL http://my.domain.com
#ENV ALLOWED_HOST my.domain.com
#ENV DJANGO_SECRET_KEY sdfsadfas32e98zsdvhhsnz6udvbksjdhfi4galshjfg
ENV OPENEATS_VERSION=1.4.0 \
    PATH=/usr/local/bin:$PATH \
    # nginx config
    API_HOST=0.0.0.0 \
    API_PORT=8000 \
    # Database config
    MYSQL_HOST=openeats-mariadb \
    MYSQL_PORT=3306 \
    MYSQL_DATABASE=openeats \
    MYSQL_USER=openeats \
    MYSQL_ROOT_PASSWORD=openeats \
    # Django config
    API_URL=0.0.0.0:8000 \
    DJANGO_SETTINGS_MODULE=base.settings \
    DJANGO_DEBUG=False \
    HTTP_X_FORWARDED_PROTO=true \
    # Node config
    NODE_ENV=production \
    NODE_URL=localhost:8080 \
    NODE_LOCALE=en

COPY default.conf /etc/nginx/conf.d/default.conf
COPY start.sh /startup/

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
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    mkdir -p /var/www/html/openeats-static && cd /openeats-web && \
    yarn install --pure-lockfile --production=false && yarn start && \
    cp -r build/ /var/www/html/openeats-static/public-ui && \
    chmod 755 /startup

CMD ["/startup/start.sh"]
