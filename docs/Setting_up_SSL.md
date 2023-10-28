# Setting Up SSL

## Introduction

Setting up SSL for OpenEats requires three things:

1) Setting up a domain name for your server
2) Acquiring an SSL certificate
3) Making necessary configuration changes in the OpenEats container services

This document assumes that you have setup OpenEats using Docker on a host or virtual machine, which is the recommended method. You will need access to your host's shell to complete the steps.

## Setting Up a Domain Name

Having a registered domain name is required in order to acquire an SSL certificate. Setting up a domain name is beyond the scope of this document. However, your provider most certainly has documentation on how to do this. You'll need to modify the DNS records of your domain name to point to your OpenEats server.

## Acquiring an SSL Certificate

You can buy certificates from many vendors, but for non-commercial purposes, you can get a free SSL certificate from [Let's Encrypt](https://letsencrypt.org/). There is an outstanding tutorial on how to setup Nginx (i.e., the default web server for OpenEats) to work with [Let's Encrypt](https://letsencrypt.org/) published at [Human Code](https://www.humankode.com/ssl/how-to-set-up-free-ssl-certificates-from-lets-encrypt-using-docker-and-nginx). Follow the steps in this tutorial to setup and acquire your certificate. 

Once your certificate is installed on your host, you will make some modifications to the [openeats-nginx](https://github.com/open-eats/openeats-nginx) application to build a custom [openeats-nginx](https://github.com/open-eats/openeats-nginx)  container that mounts the appropriate files. This will provide OpenEats access to the SSL certificate which should be located outside of the OpenEats containers (i.e., on you host machine). This is important because [Let's Encrypt](https://letsencrypt.org/) certificates are only valid for three months. Locating certificate files outside of your OpenEats containers makes it easier to renew them. A process for setting up an automatic renewal is detailed in the [Human Code](https://www.humankode.com/ssl/how-to-set-up-free-ssl-certificates-from-lets-encrypt-using-docker-and-nginx) tutorial.

## Making Changes to the OpenEats Applications

After acquiring your SSL certificate, you will need to make the following changes to your OpenEats applications. This document assumes you are using Docker to deploy the applications.
1) Update the [openeats-api](https://github.com/open-eats/openeats-api) container to specify `https://` for site-media.
2) Update the [openeats-nginx](https://github.com/open-eats/openeats-nginx) container to support SSL.
3) Update configuration files to support SSL.

### Updating the [openeats-api](https://github.com/open-eats/openeats-api) Container

At the time of this writing, there is a bug in the [openeats-api](https://github.com/open-eats/openeats-api) which causes site-media not to route through the nginx SSL server correctly. This results in mixed content errors in the browser. In order to fix this, you should open `openeats-api/base/settings.py` and edit the MEDIA_URL value to specify `https://`:

```
# original value:
# MEDIA_URL = '/site-media/'
# new value 
MEDIA_URL = 'https://www.my.domain.com/site-media/'
```
Note that `www` should be included in the URL. You'll understand why in the next section. 

Once you make this change, you should use Docker to build the container and deploy it in your application.

### Updating the [openeats-nginx](https://github.com/open-eats/openeats-nginx) Container

Necessary changes to get [openeats-nginx](https://github.com/open-eats/openeats-nginx)  working with your new certificate are detailed in an example nginx configuration file which is located in the [openeats-nginx](https://github.com/open-eats/openeats-nginx) root directory in a file named `default-ssl.conf` Copy the contents `default-ssl.conf` into `default.conf` with the necessary changes reflecting your domain name and certificate fil locations, then build the container using Docker and deploy it in your application.

### Updating Your Configuration Files

This [OpenEats](https://github.com/open-eats/OpenEats) repo has two example files that will be helpful when setting up SSL. These files are located in the `docs/samples directory`. They include:

1) [`sample_docker_prod_override_ssl.yml`](samples/sample_docker_prod_override_ssl.yml)
2) [`sample_env_file_ssl.list`](samples/sample_env_file_ssl.list)

From inside the `OpenEats/` directory, issue these commands to copy them:
```
cp docs/samples/sample_docker_prod_override_ssl.yml docker-prod.override.yml
cp docs/samples/sample_env_file_ssl.list env_prod.list
```
Then modify the copied files to match your domain.

Also note that the `quick-start.py` file used to restart the application by default pulls from the latest OpenEats Docker images. You may wish to modify this file to reflect the new Docker images you've built to support SSL, whether they are located locally, or in a remote container repository.

