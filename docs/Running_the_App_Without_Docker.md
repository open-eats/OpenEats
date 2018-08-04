## Install dependencies

`$ apt-get install python3 python3-pip git build-essential`

## Nodejs

### Install nodejs

`$ curl -sL `<https://deb.nodesource.com/setup_8.x>` -o nodesource_setup.sh`  
`$ bash nodesource_setup.sh`

Further help to installing nodejs:
<https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-debian-8>

## Database

We will use Mariadb but if you have working MySQL server you can skip
the Mariadb installation part.

### install Mariadb

Add mariadb
[repository](https://downloads.mariadb.org/mariadb/repositories/) to
`/etc/apt/sources.list.d/mariadb.conf`

`$ apt-get install software-properties-common dirmngr`  
`$ apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8`  
`$ add-apt-repository 'deb [arch=amd64,i386,ppc64el] `<http://ftp.bme.hu/pub/mirrors/mariadb/repo/10.1/debian>` stretch main'`  
`$ apt-get update`  
`$ apt-get install mariadb-server`

### Create openeats user and database in mariadb (ssh)

#### Log into your MySQL database

`$ mysql -p`

#### Create database

`$ create database `**`openeats`**`;`

#### Create a database user and password

*Change username and password. You will have to change in configuration
files
too-*

`$ grant all privileges on `**`openeats`**`.* to `**`'username`**`'@'localhost' identified by "`**`password`**`";`

#### Commit changes

`$ flush privileges;`

#### Exit from mysql

`$ exit;`

## Create directory infrastructure

`$ mkdir /opt/openeats/`  
`$ mkdir /opt/openeats/openeats-apache2/`

## Set up the openeats-api

`$ cd /opt/openeats/`

### Get the source of openeats-api from git

`$ git clone `<https://github.com/open-eats/openeats-api.git>  
`$ cd /opt/openeats/openeats-api`

### Install the python requirements

`$ pip3 install -r /opt/openeats/openeats-api/base/requirements.txt`

### Create .env environment file

`$ touch /opt/openeats/openeats-api/.env`

### Edit the created .env file and insert the following data in it

*Read the comments carefully and change the necessary parts to your
configuration.*

Our api will listen on port 5210.

```
# Database config
MYSQL_HOST=localhost
MYSQL_DATABASE=`**`openeats`**  
MYSQL_USER=`**`username`**  
MYSQL_ROOT_PASSWORD=`**`password`**  
  
# Django config`  
API_URL=0.0.0.0:`**`5210`**  
API_PORT=`**`5210`**  
DJANGO_SECRET_KEY=`**`CHANGE_THIS:SECRETKEY`**`
DJANGO_SETTINGS_MODULE=base.settings  
DJANGO_DEBUG=False
ALLOWED_HOST=`**`openeats.domain.com`**`
  
# If you are serving content behind an HTTPS proxy,
# Set this to `true`.
# See: `<https://docs.djangoproject.com/en/1.10/ref/settings/#secure-proxy-ssl-header>  
HTTP_X_FORWARDED_PROTO=true
  
# Node config
NODE_ENV=development
NODE_URL=openeats.domain.com:5200
NODE_API_URL=`<https://openeats.domain.com>
```
