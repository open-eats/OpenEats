#!/usr/bin/env python
# encoding: utf-8

import requests
from requests.auth import HTTPBasicAuth
from secrets.secrets import username, password


def release(_repo, _tag, _name, _target, _body, _draft, _prerelease):
    response = requests.post(
        'https://api.github.com/repos/open-eats/%s/releases' % _repo,
        json={
          "tag_name": _tag,
          "target_commitish": _target,
          "name": _name,
          "body": _body,
          "draft": _draft,
          "prerelease": _prerelease
        },
        auth=HTTPBasicAuth(username, password)
    )
    print(response)


if __name__ == '__main__':
    from sys import argv
    print("Starting Release")

    try:
        # required
        tag = argv[1]
        name = argv[2]

        # optional
        try:
            body = argv[3]
        except IndexError:
            body = argv[2]
        try:
            target = argv[4]
        except IndexError:
            target = 'master'
        try:
            draft = argv[5].lower() == 'true'
        except IndexError:
            draft = False
        try:
            prerelease = argv[6].lower() == 'true'
        except IndexError:
            prerelease = False

        release('openeats-api', tag, name, target, body, draft, prerelease)
        release('openeats-web', tag, name, target, body, draft, prerelease)
        release('openeats-nginx', tag, name, target, body, draft, prerelease)
        release('OpenEats', tag, name, target, body, draft, prerelease)
    except IndexError:
        exit('Please add a tag name and release name')
