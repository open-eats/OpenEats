**The recommended way to run this app is with docker. However, if you wish not to use docker this page will explain the actions needed to run OpenEats without it.**

*Please note, most every line that contains commands will require either running as root or sudo*

## Install Dependencies

`apt-get install python3 python3-pip git build-essential`



## Nodejs

### Install Nodejs

```
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
```
To ensure you get the up-to-date version of node, you'll need to make a modification to your apt-cache policy.

```
nano /etc/apt/preferences.d/nodesource
```
Insert the following:

```
Package: *
Pin: origin deb.nodesource.com
Pin-Priority: 600
```
Then:

```sudo apt-get install nodejs```

## Database

We will use MariaDB.

### Install MariaDB
```
apt install mariadb-server
```
Don't forget to run `mysql_secure_installation`!

### Install Additional Dependencies

`apt install default-libmysqlclient-dev libssl-dev`

### Create OpenEats User and Database in MariaDB (ssh)

#### Log Into Your MySQL Database

`mysql`

#### Create Database

`CREATE DATABASE openeats;`

#### Create a Database User and Password

*Change username and password. You will have to change that in the configuration files, too.*

`GRANT ALL PRIVILEGES ON openeats.* TO 'username'@'localhost' IDENTIFIED BY 'password';`

#### Commit Changes

`FLUSH PRIVILEGES;`

#### Exit From MySQL

`EXIT;`



## Create Directory Infrastructure

```
mkdir /opt/openeats/
mkdir /opt/openeats/openeats-apache2/
```

## Set up the OpenEats-api

`cd /opt/openeats/`

### Get the Source of OpenEats-api from Github

```
git clone https://github.com/open-eats/openeats-api.git
cd /opt/openeats/openeats-api
```

### Install the Python Requirements

`pip3 install -U -r /opt/openeats/openeats-api/base/requirements.txt`

### Create .env Environment File

`touch /opt/openeats/openeats-api/.env`

### Edit the Created .env File and Insert the Following Data

*Read the comments carefully and change the necessary parts to match your system*

Our api will listen on port **5210**

```
# Database config
MYSQL_HOST=localhost
MYSQL_DATABASE=openeats
MYSQL_USER=username
MYSQL_ROOT_PASSWORD=password

# Django config
API_URL=127.0.0.1:5210
API_PORT=5210
DJANGO_SECRET_KEY=<CHANGE_THIS:SECRETKEY>
DJANGO_SETTINGS_MODULE=base.settings
DJANGO_DEBUG=False
ALLOWED_HOST=<openeats.domain.com>
  
# If you are serving content behind an HTTPS proxy,
# Set this to `true`.
# See: <https://docs.djangoproject.com/en/1.10/ref/settings/#secure-proxy-ssl-header>
HTTP_X_FORWARDED_PROTO=true
  
# Node config
NODE_ENV=development
NODE_URL=openeats.domain.com:5200
NODE_API_URL=https://openeats.domain.com
NODE_LOCALE=en
```
The `DJANGO_SECRET_KEY` should be reasonably random-looking, using `pwgen` or random characters is recommended.

### Edit the /opt/openeats/openeats-api/base/prod-entrypoint.sh file

*The paths should be adjusted to your infrastructure*

```
#!/usr/bin/env sh

BASEDIR=/opt/openeats/openeats-api

# Update the DB if it needs it and compile static files.
python3 $BASEDIR/manage.py migrate --no-input
python3 $BASEDIR/manage.py collectstatic --no-input

# Start up gunicorn
bash $BASEDIR/base/gunicorn_start.sh
```

### Edit the /opt/openeats/openeats-api/base/settings.py file

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_DATABASE', 'openeats'),
        'USER': os.environ.get('MYSQL_USER', 'root'),
        'PASSWORD': os.environ.get('MYSQL_ROOT_PASSWORD', ''),
        'HOST': os.environ.get('MYSQL_HOST', 'db'),
        'PORT': os.environ.get('MYSQL_PORT', '3306'),
        'OPTIONS': {
            'charset': 'utf8mb4'
        },
        'TEST': {
            'NAME': os.environ.get('MYSQL_TEST_DATABASE', 'test_openeats')
        }
    }
}
```
Edit this to include the same options you set in your `.env`.

### Edit the /opt/openeats/openeats-api/base/gunicorn_start.sh file

*The paths should be adjusted to your infrastructure*

```
#!/usr/bin/env sh

NAME="OpenEats"                                   # Name of the application
DJANGODIR=/opt/openeats/openeats-api        	  # Django project directory
USER=root                                         # the user to run as
GROUP=root                                        # the group to run as
NUM_WORKERS=5                                     # how many worker processes should Gunicorn spawn
DJANGO_SETTINGS_MODULE=base.settings              # which settings file should Django use
DJANGO_WSGI_MODULE=base.wsgi                      # WSGI module name

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=$API_URL
```

### Create systemd service to run the api

Create and edit `/lib/systemd/system/openeats.service`

*The paths should be adjusted to your infrastructure*

```
[Unit]
Description=OpenEats
After = mariadb.service systemd-user-sessions.service network-online.target systemd-networkd.service

[Service]
Type=simple
User=root

EnvironmentFile=/opt/openeats/openeats-api/.env
ExecStart =/usr/bin/ionice -c 3 /usr/bin/nice -n 18 /bin/bash /opt/openeats/openeats-api/base/prod-entrypoint.sh
Restart = always
RestartSec = 1

# Configures the time to wait before service is stopped forcefully.
TimeoutStopSec=2000

[Install]
WantedBy=multi-user.target
```

### Start the api

`systemctl start openeats.service`

### Check if the api running correctly

`systemctl status openeats.service`


## Set up the openeats-web

`cd /opt/openeats/`

### Get the source of openeats-Web from git

```
git clone https://github.com/open-eats/openeats-web.git
cd /opt/openeats/openeats-web/
```

### Create environment file in /opt/openeats-web/

`touch /opt/openeats/openeats-web/.env`

### Edit the created .env file and insert the following data in it

*Read the comments carefully and change the necessary parts to your configuration.*

**This should contain the same values like .env in the openeats-api directory, but every line should start with export**

Our api will still listen on port **5210**

```
# Database config
export MYSQL_HOST=localhost
export MYSQL_DATABASE=openeats
export MYSQL_USER=username
export MYSQL_ROOT_PASSWORD=password

# Django config
export API_URL=127.0.0.1:5210
export API_PORT=5210
export DJANGO_SECRET_KEY=<CHANGE_THIS:SECRETKEY>
export DJANGO_SETTINGS_MODULE=base.settings
export DJANGO_DEBUG=False
export ALLOWED_HOST=openeats.domain.com

# If you are serving content behind an HTTPS proxy,
# Set this to `true`.
# See: https://docs.djangoproject.com/en/1.10/ref/settings/#secure-proxy-ssl-header
export HTTP_X_FORWARDED_PROTO=true 

# Node config
export NODE_ENV=development
export NODE_URL=openeats.domain.com:5200 
export NODE_API_URL=https://openeats.domain.com 
export NODE_LOCALE=en
```

### Load the environment values

```
cd /opt/openeats/openeats-web/
. ./.env
```

### Install the dependecies

```
npm install --update
```
`node-sass` should blow up here. That's okay, we'll fix it.
```
npm rebuild node-sass --force --unsafe-perms=yes --allow-root
```
This forces `node-sass` to install on Node 13. `npm` ***will*** get angry at you but it will do what you ask here.
```
npm install yarn
```

### Build openeats-web

`/opt/openeats/openeats-web/node_modules/yarn/bin/yarn start`

This will create a build directory in `/opt/openeats/openeats-web/`


## Install Apache 2

**Info: The docker version uses nginx.**

`apt-get install apache2`

### Create symbolic links for Apache2

```
cd /opt/openeats/openeats-apache2/
ln -s /opt/openeats/openeats-web/build /opt/openeats/openeats-apache2/public-ui
ln -s /opt/openeats/openeats-api/static-files /opt/openeats/openeats-apache2/static-files
ln -s /opt/openeats/openeats-api/site-media /opt/openeats/openeats-apache2/site-media
```

*Openeats will create the* **site-media** *directory when you upload the first image.*

### Edit /etc/apache2/sites-available/default.conf


```
   <VirtualHost *:80>
       ServerName openeats.domain.com
       ServerAdmin postmaster@domain.com
       Header always set Strict-Transport-Security "max-age=15768000"
       DocumentRoot "/opt/openeats/openeats-apache2/public-ui"
       <Directory "/opt/openeats/openeats-apache2/public-ui">
           # HANDLE 404 ERROR ON REFRESH
           RewriteEngine On
           RewriteBase /
           RewriteRule ^index\.html$ - [L]
           RewriteCond %{REQUEST_FILENAME} !-f
           RewriteCond %{REQUEST_FILENAME} !-d
           RewriteRule . /index.html [L]
           # HANDLE 404 ERROR ON REFRESH END
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Order allow,deny
           allow from all
           Require all granted
       </Directory>

       Alias /static /opt/openeats/openeats-apache2/public-ui/static
       <Location "/static/">
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Order allow,deny
           allow from all
           Require all granted
           AddOutputFilterByType DEFLATE text/plain
           AddOutputFilterByType DEFLATE text/javascript
           AddOutputFilterByType DEFLATE application/javascript
           AddOutputFilterByType DEFLATE application/xml
           AddOutputFilterByType DEFLATE application/xhtml+xml
       </Location>

       <Location "/api/">
           ProxyPass http://127.0.0.1:5210/api/
           ProxyPassReverse http://127.0.0.1:5210/api/
       </Location>

       <Location "/admin/">
           ProxyPass http://127.0.0.1:5210/admin/
           ProxyPassReverse http://127.0.0.1:5210/admin/
       </Location>

       Alias /static-files /opt/openeats/openeats-apache2/static-files
       <Directory "/opt/openeats/openeats-apache2/static-files">
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Order allow,deny
           allow from all
           Require all granted
       </Directory>
       Alias /site-media /opt/openeats/openeats-apache2/site-media
       <Directory "/opt/openeats/openeats-apache2/site-media">
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Order allow,deny
           allow from all
           Require all granted
       </Directory>
   </VirtualHost>
```

### Reload Apache configuration

`service apache2 restart`

Your openeats installation should run on your http://openeats.domain.com.

It is HIGHLY recommended you eventually switch over to an HTTPS setup. Let's Encrypt is great for getting that set up.


## Updating openeats

`cd /opt/openeats/`

### Get the update from git sources

```
git clone https://github.com/open-eats/openeats-api.git
git clone https://github.com/open-eats/openeats-web.git
```

### Update the paths in your configuration files

* Update paths in prod-entrypoint.sh
* Update paths in gunicorn_start.sh 

### Rebuild openeats-web

* Load environment values in the current session
* Rebuild openeats-web with yarn

### Restart services

```
systemctl restart openeats.service
systemctl reload apache2.service
```
