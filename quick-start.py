#!/usr/bin/env python
# encoding: utf-8

from time import sleep
from os import getcwd
from subprocess import call, Popen, PIPE


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

    call(['docker-compose', '-f', 'docker-prod.yml', 'stop', 'nginx'])
    call(['docker-compose', '-f', 'docker-prod.yml', 'stop', 'api'])
    call(['docker-compose', '-f', 'docker-prod.yml', 'stop', 'web'])
    call(['docker-compose', '-f', 'docker-prod.yml', 'up', '-d'])

    print("App started. Please wait ~30 seconds for the containers to come online.")


if __name__ == '__main__':
    from sys import argv
    print("OpenEats quick setup script")
    try:
        download_images(argv[1])
    except IndexError:
        download_images(None)

    start_containers()
