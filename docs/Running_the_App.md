# Running the App

The recommended way to run this app is with docker. You can install docker [here](https://www.docker.com/community-edition#/download). If you are not familiar with docker you can read more about it on [their website](https://www.docker.com/what-docker).

### Running the app with docker for production

First clone this repo:
```bash
git clone https://github.com/open-eats/OpenEats.git
cd OpenEats
```

Then, create two files from the sample files:
- docker-prod.override.yml
- env_prod.list

```bash
cp docker-prod.override.yml docs/sample_docker_prod_override.yml
cp env_prod.list docs/sample_env_file.list
```

The `docker-prod.override.yml` contains the list of images to run the app. It comes with an nginx reverse proxy that by default will run on port 80. You will most likely want to change the port that nginx runs on as well as use a fix tag for the image. By default, all are set to latest.

#### Configure the environment file
Most of the settings in your `env_prod.list` can stay the same as `env_stg.list` that is in this repo. There are a few config settings that need to be changed for most configurations. See [Setting_up_env_file.md](Setting_up_env_file.md) for a complete description of the environment variables.

- [DATABASE_PASSWORD](Setting_up_env_file.md#DATABASE_PASSWORD)
- [DJANGO_SECRET_KEY](Setting_up_env_file.md#DJANGO_SECRET_KEY)
- [ALLOWED_HOST](Setting_up_env_file.md#ALLOWED_HOST)
- [NODE_API_URL](Setting_up_env_file.md#NODE_API_URL)


Once the files have been created run the command below and replace the version with version of OpenEats you want to run. You can also leave this blank (this will pull the latest code)

```bash
./quick-start.py 1.0.3
```
OR
```bash
./quick-start.py
```

The quick start script will do a few things.
1. Creates a `docker-prod.version.yml` file with the required image tags.
2. Downloads the required images.
3. Takes a backup of the database and your images.
4. Restarts the OpenEats servers.

### First Time Setup

To create a super user:
``` bash
docker-compose -f docker-prod.yml run --rm --entrypoint 'python manage.py createsuperuser' api
```
Follow the prompts given to create your user. You can do this as many times as you like.

If you are an english user, it is highly recommended to add course and cuisine data. Run `docker-compose run --rm api bash` to open a bash shell to the API. Then:
```bash
./manage.py loaddata course_data.json
./manage.py loaddata cuisine_data.json
```

If you want to add some test data you can load a few recipes and some news data. This data isn't really needed unless you just wanna see how the app looks and if its working.
```bash
./manage.py loaddata news_data.json
./manage.py loaddata recipe_data.json
./manage.py loaddata ing_data.json
```
