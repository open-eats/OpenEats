## Running OpenEats

#### Warning! This docs are outdated. The recommended way to install OpenEats is via docker.

* `git clone https://github.com/RyanNoelk/openeats.git`
* `cd openeats/api`
* `git checkout dev`
* Create a python virtual environment (I use [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)).
* `pip install -r base/requirements.txt`

Next we need to create a `base/local_settings.py` file for configuring your particulate instance. Things like your secret key and database settings should go here.

Now that we have the dependencies. We need to setup the DB. The default is sqlite, which is fine for dev purposes. But if you want something a bit more robust or if you want to run this in a production environment you should use something like postgres or mysql. The current configuration should work with any database you choose to use. See the [django database docs](https://docs.djangoproject.com/en/1.10/ref/settings/#std:setting-DATABASES) for setting up your database. As a side note, please make sure that you install any additional drivers that python needs to work with the database that you choose.

The migrations should all be present in the repo. Once the database is installed, migrate all the apps.
* `./manage.py migrate`

Now lets create a super user as an admin for the site. Run `./manage.py createsuperuser` and follow the prompts.

Once you have created a user, we can add some base data to the project. This will load some basic course and cuisine data into the project.
* `./manage.py loaddata course_data.json`
* `./manage.py loaddata cuisine_data.json`

If you want to add some test data we can load a few recipes and some news data. This data isn't really needed unless you just wanna see how the app looks and if its working.
* `./manage.py loaddata news_data.json`
* `./manage.py loaddata recipe_data.json`
* `./manage.py loaddata ing_data.json`
* `./manage.py loaddata direction_data.json`

Now we need to gather all the static fields for the django rest framework and django admin panel.

* `./manage.py collectstatic`

That should be it! you can run the dev server now to load up the api `./manage.py runserver`.

Load up `http://localhost:8000/admin/` in a browser and see the results.

The next thing we need to do is setup react. The bundle and index are located in `frontend/public/` The bundle there is already a production copy.  That should be used if your looking to just serve the project with, for example, nginx. However if you want node to serve the code. See below

From your base dir:
* `cd frontend` 
* `npm install` (this will take a few minutes as its loading a ton of small static files)
* `NODE_ENV=production npm start`
* Load `http://localhost:8080` in a browse and see the results.

If you just want to test or play around with the code, you can run the dev server. First, make sure the  django server is running. Then:
* `cd frontend` 
* `npm install` (this will take a few minutes as its loading a ton of small static files)
* `npm start`
* Load `http://localhost:8080` in a browse and see the results.
