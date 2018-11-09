## Configuing your Environment

This file will provide some context on the env file.


## Database config
Docker configurations come with MariaDB. We only need to set to options, the rest are not required.
For a full list of settings see: https://hub.docker.com/_/mariadb/

#### MYSQL_DATABASE
The database name.

EX: `MYSQL_DATABASE=openeats`

#### MYSQL_USER
The user for the database.

EX: `MYSQL_USER=openeats`

#### MYSQL_ROOT_PASSWORD
The password for the user given above.

EX: `MYSQL_ROOT_PASSWORD=root`

#### MYSQL_HOST
The address or hostname of the DB. Do not include this in your env file if you are using docker to house the DB.

EX: `MYSQL_HOST=my.db.com`

#### MYSQL_PORT
The port the database is exposed on.

EX: `MYSQL_PORT=3306`


## Django config
#### API_URL
This URL and port combination is used my gunicorn to server the API.
For docker instances we need to server via `0.0.0.0`.
`0.0.0.0` means "all IPv4 addresses on the local machine". 
If a host has two IP addresses, 192.168.1.1 and 10.1.2.1, 
and a server running on the host listens on 0.0.0.0, 
it will be reachable at both of those IPs.

EX: `API_URL=0.0.0.0:8000`

#### API_PORT
The port the API is served from.

EX: `API_PORT=8000`

#### DJANGO_SECRET_KEY
A secret key for a particular Django installation. 
This is used to provide cryptographic signing, and should be set to a unique, unpredictable value.
You can create one yourself or use a generator to do so.

For more information, see: https://docs.djangoproject.com/en/1.11/ref/settings/#std:setting-SECRET_KEY

EX: `DJANGO_SECRET_KEY=sdfsadfas32e98zsdvhhsnz6udvbksjdhfi4galshjfg`

#### DJANGO_SETTINGS_MODULE
The settings file that django will use.

EX: `DJANGO_SETTINGS_MODULE=base.settings`

#### DJANGO_DEBUG
Set environment to the Django app in.
This should be set to `False` in production and `True` to debug any issues.

EX: `DJANGO_DEBUG=False`

#### ALLOWED_HOST
The hostname that the API is being served from.

For more information, see: https://docs.djangoproject.com/en/1.11/ref/settings/#allowed-hosts

EX: `ALLOWED_HOST=ryannoelk.com`

#### HTTP_X_FORWARDED_PROTO
If you are serving content behind an HTTPS proxy. 
Set this to `True`, otherwise `False`.
If you are using the docker configuation, set this to `True`.

For more information, see: https://docs.djangoproject.com/en/1.10/ref/settings/#secure-proxy-ssl-header

EX: `HTTP_X_FORWARDED_PROTO=False`


## Node config

#### NODE_ENV=production
This tells node whether to build a production or dev version of the bundle.

EX: `NODE_ENV=production`

#### NODE_URL
The URL and port node is served from.
The API will use this to prevent CORS issues.

EX: `NODE_URL=localhost:8080`

#### NODE_API_URL
The hostname/port (my.example.com:8080) the frontend will call the API from. 
If unset, the UI will call the API from the same hostname/port. If you are not using the default Nginx server that OpenEats comes with, you will either need to set this or configure your own proxy server to redirect all traffic that starts with `/api` or `/admin`.

EX: `NODE_API_URL=http://localhost:8080`, `NODE_API_URL=https://api.example.com`

#### NODE_LOCALE
The language the UI will be in.

Options:
- English: en
- German: de
- Spanish: es
- French: fr

EX: `NODE_LOCALE=en`
