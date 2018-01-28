### Generating updated locale files

After adding new `defineMessages` you'll need to update the locale files. Instead of doing it manually you can run this script to do it for you.

```bash
docker-compose run --rm node sh
./node_modules/.bin/babel-node scripts/merge-locale.js
```