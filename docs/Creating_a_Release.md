# Creating a Release

1. Get an Auth token from github. See [Github Help](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) for details on how to do this.
2. Create a secrets folder and add a file with the following content:
    ```python
    #!/usr/bin/env python
    # encoding: utf-8
    
    username = 'username'
    password = 'token'
    ```
3. Create a release doc and place in the releases folder. See the release folder for examples.
4. Once you have a release file created, you can run the release script. This script takes the release file you just created as its only argument.
  - `./release x.x.x.json`
