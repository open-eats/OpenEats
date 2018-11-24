#!/usr/bin/env python
# encoding: utf-8

import json
import requests
from requests.auth import HTTPBasicAuth
from secrets.secrets import username, password


def release(_repo, _tag, _name, _target, _body, _draft, _prerelease):
    """
    Send a post request to github to log a release.
    Then print out the response status and message.
    """
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
    print('Status: %s' % response)
    print('Response: %s' % response.text)


# Define some help test that the json file should follow.
help_text = '''
A JSON file with release info in it. See below for an example.
{
  "tag": "1.1.1",
  "name": "Release Test",
  "body": "the is a test release!",
  "target": "master",
  "draft": false,
  "prerelease": false
}
'''


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(
        description='OpenEats release script.'
    )
    # Require a json file as part of the script
    parser.add_argument(
        'release',
        type=str,
        help=help_text
    )

    # Open the json file and try and parse it into a json file
    with open(parser.parse_args().release, 'r') as fp:
        args = json.loads(fp.read())

    # All json files should have this format.
    json_format = [
        'tag',
        'name',
        'target',
        'body',
        'draft',
        'prerelease',
    ]

    # Iterate through the `json_format` array and
    # make sure the json file supplied has all the required fields.
    for key in json_format:
        try:
            tmp = args[key]
        except (IndexError, KeyError):
            print("$s missing! Please add it." % key)
            exit(1)

    # The list of repos we want to push a release to.
    repos = [
        'openeats-nginx',
        'openeats-api',
        'openeats-web',
        'OpenEats'
    ]

    # Run a release for all the repos with the data from json file.
    for r in repos:
        release(
            r,
            args.get('tag'),
            args.get('name'),
            args.get('target'),
            args.get('body'),
            args.get('draft'),
            args.get('prerelease')
        )
