# Running the App

The recommended way to run this app is with docker. You can install docker [here](https://www.docker.com/community-edition#/download) and docker-compose [here](https://docs.docker.com/compose/install/#prerequisites). If you are not familiar with docker you can read more about it on [their website](https://www.docker.com/what-docker).

### Running the app with docker for development

First you'll need to fork the appropriate repo that you are looking to make changes to, alone witht he core repo. See below for a sample.

```bash
git clone https://github.com/open-eats/OpenEats.git
cd OpenEats

git clone https://github.com/open-eats/openeats-api.git
git clone https://github.com/open-eats/openeats-web.git

docker-compose build
docker-compose up
```

### First Time Setup

Regardless of if your running the app in production or development, you need to seed the database.

To create a super user:
``` bash
docker-compose -f docker-prod.yml run --rm --entrypoint 'python manage.py createsuperuser' api
```
Follow the prompts given to create your user. You can do this as many times as you like.

If you want to add some test data you can load a few recipes and some news data. This data isn't really needed unless you just wanna see how the app looks and if its working.
```bash
docker-compose -f docker-prod.yml run --rm --entrypoint 'sh' api
./manage.py loaddata course_data.json
./manage.py loaddata cuisine_data.json
./manage.py loaddata news_data.json
./manage.py loaddata recipe_data.json
./manage.py loaddata ing_data.json
```
