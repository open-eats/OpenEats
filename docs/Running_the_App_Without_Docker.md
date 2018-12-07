## Install Dependencies

`apt-get install python3 python3-pip git build-essential`

## Nodejs

### Install Nodejs

```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs npm
```

Further help to installing nodejs:
<https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-debian-8>

## Database

We will use Mariadb but if you have working MySQL server you can skip the Mariadb installation part.

### Install MariaDB

Add mariadb
[repository](https://downloads.mariadb.org/mariadb/repositories/) to
`/etc/apt/sources.list.d/mariadb.conf`

```
apt-get install software-properties-common dirmngr
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] `<http://ftp.bme.hu/pub/mirrors/mariadb/repo/10.1/debian>` stretch main'
apt-get update
apt-get install mariadb-server
```

### Install Additional Dependencies

`apt-get install libmysqlclient-dev libssl-dev`

### Create OpenEats User and Database in MariaDB (ssh)

#### Log Into Your MySQL Database

`mysql -p`

#### Create Database

`create database `**`openeats`**`;`

#### Create a Database User and Password

*Change username and password. You will have to change in configuration files too-*

`grant all privileges on `**`openeats`**`.* to `**`'username`**`'@'localhost' identified by "`**`password`**`";`

#### Commit Changes

`flush privileges;`

#### Exit From MySQL

`exit;`

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

*Read the comments carefully and change the necessary parts to your configuration.*

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
