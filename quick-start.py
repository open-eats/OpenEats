#!/usr/bin/env python
# encoding: utf-8

from time import sleep
from os import getcwd
from subprocess import call, Popen, PIPE


def update_image_tags(version=None):
    version = version if version is not None else 'latest'
    version = '''version: '2.3'
      services:
        api:
          image: openeats/openeats-api:%s
        web:
          image: openeats/openeats-web:%s
        nginx:
          image: openeats/openeats-nginx:%s
    ''' % (version, version, version)
    with open('docker-prod.version.yml', 'w') as f:
        f.write(version)


def download_images(version=None):
    version = version if version is not None else 'latest'
    print("==================")
    print("Downloading Images")
    print("==================")
    call(['docker', 'pull', 'openeats/openeats-api:' + version])
    call(['docker', 'pull', 'openeats/openeats-web:' + version])
    call(['docker', 'pull', 'openeats/openeats-nginx:' + version])


def start_containers():
    print("==================")
    print("Starting OpenEats")
    print("==================")

    p = Popen(
        ['docker', 'ps', '-q', '-f', 'name=openeats_db_1'],
        stdin=PIPE,
        stdout=PIPE,
        stderr=PIPE
    )
    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    if output and not err:
        print("Taking a database backup (saving as openeats.sql)...")
        call(
            'docker exec openeats_db_1 sh -c ' +
            '\'exec mysqldump openeats -uroot -p"$MYSQL_ROOT_PASSWORD"\'' +
            ' > openeats.sql',
            shell=True
        )
    else:
        print("Creating the DB. This may take a minute...")
        call(['docker-compose', '-f', 'docker-prod.yml', 'up', '-d', 'db'])
        sleep(45)

    p = Popen(
        ['docker', 'ps', '-q', '-f', 'name=openeats_api_1'],
        stdin=PIPE,
        stdout=PIPE,
        stderr=PIPE
    )
    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    if output and not err:
        print("Taking a image backup save to 'site-media'...")
        call(
            'docker cp openeats_api_1:/code/site-media/ ' + getcwd(),
            shell=True
        )

    call([
        'docker-compose',
        '-f', 'docker-prod.yml',
        '-f', 'docker-prod.version.yml',
        '-f', 'docker-prod.override.yml',
        'stop', 'nginx'
    ])
    call([
        'docker-compose',
        '-f', 'docker-prod.yml',
        '-f', 'docker-prod.version.yml',
        '-f', 'docker-prod.override.yml',
        'stop', 'api'
    ])
    call([
        'docker-compose',
        '-f', 'docker-prod.yml',
        '-f', 'docker-prod.version.yml',
        '-f', 'docker-prod.override.yml',
        'stop', 'web'
    ])
    call([
        'docker-compose',
        '-f', 'docker-prod.yml',
        '-f', 'docker-prod.version.yml',
        '-f', 'docker-prod.override.yml',
        'up', '-d'
    ])

    print("App started. Please wait ~30 seconds for the containers to come online.")


if __name__ == '__main__':
    from sys import argv
    print("OpenEats quick setup script")
    try:
        update_image_tags(argv[1])
        download_images(argv[1])
    except IndexError:
        update_image_tags(None)
        download_images(None)

    start_containers()
