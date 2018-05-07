# Creating a Release

1. Get an Auth token from github. See Github for details on how to do this.
2. Create a secrets folder and add a filer with the below strcuture:
    ```python
    #!/usr/bin/env python
    # encoding: utf-8
    
    username = 'username'
    password = 'token'
    ```
3. Create a release doc and place in the releases folder. See the release folder for examples.
4. Once you have a release file created, you can run the release script. This script takes the release file you just created as it's only arg.
  - `./release x.x.x.json`