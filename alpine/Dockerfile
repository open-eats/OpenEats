FROM nginx:1.14.2-alpine

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
    SUPERUSER_NAME=openeats \
    SUPERUSER_PASSWORD=openeats \
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

RUN apk add --update-cache --update --virtual builddeps \
        # fetch deps
        tar \
        openssl \
        ca-certificates \
        # pillow deps
        python3-dev \
        libjpeg-turbo-dev \
        gcc \
        musl-dev \
        # node deps
        yarn && \
    apk add --update-cache --update \
        mariadb-dev \
        python3 && \
    cd /tmp && \
    wget -O openeats-web.tar.gz "https://github.com/open-eats/openeats-web/archive/$OPENEATS_VERSION.tar.gz" && \
    wget -O openeats-api.tar.gz "https://github.com/open-eats/openeats-api/archive/$OPENEATS_VERSION.tar.gz" && \
    tar -xzf openeats-web.tar.gz && rm openeats-web.tar.gz && mv openeats-web-$OPENEATS_VERSION /openeats-web && \
    tar -xzf openeats-api.tar.gz && rm openeats-api.tar.gz && mv openeats-api-$OPENEATS_VERSION /code && \
    chmod +x /code/base/prod-entrypoint.sh && \
    pip3 install -r /code/base/requirements.txt && \
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    mkdir -p /var/www/html/openeats-static /code/static-files /code/site-media && \
    cd /openeats-web && yarn install --pure-lockfile --production=false && yarn start && \
    cp -r build/ /var/www/html/openeats-static/public-ui && \
    ln -s /code/static-files /var/www/html/openeats-static/ && \
    ln -s /code/site-media /var/www/html/openeats-static/ && \
    chmod 755 /startup && \
    apk del tar openssl yarn

CMD ["/startup/start.sh"]
