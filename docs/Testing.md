# Running tests


Tests run in their own container with the following command (`-p tests` is to use a different prefix
from the normal containers to avoid overlap):

```bash
docker-compose -f docker-compose-test.yml -p test up -d
```

And then either see the result of the tests

```bash
docker-compose -f docker-compose-test.yml -p test logs api
````

Or to just get the response code (`0` for success/no errors):

```bash
docker wait tests_api_1
```

## API

To avoid the docker startup overhead or for more fine-grained control of which tests to run:

```bash
docker-compose -f docker-compose-test.yml -p test run --rm api sh
./tests.sh # Optional DB reset
./manage.py test -k
```

## React

We are using jest to run the tests as of right now. To avoid the docker startup overhead or for more fine-grained control of which tests to run:

```bash
docker-compose -f docker-compose-test.yml -p test run --rm node sh
npm test
```
