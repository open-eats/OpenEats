FROM nginx:1.14.2-alpine

ENV NODE_VERSION 8.11.1

RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
  # gpg keys listed at https://github.com/nodejs/node#release-team
  && for key in \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
  ; do \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
    && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xf "node-v$NODE_VERSION.tar.xz" \
    && cd "node-v$NODE_VERSION" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -Rf "node-v$NODE_VERSION" \
    && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

ENV YARN_VERSION 1.5.1

RUN apk add --no-cache --virtual .build-deps-yarn curl gnupg tar \
  && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
  && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && mkdir -p /opt \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && apk del .build-deps-yarn

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
        musl-dev && \
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
