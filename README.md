This fork adds support for raspberryPi/ARM docker images. The quick-start.py script uses the new docker hub images (see my forks of the other OpenEats repos). The main differences are some newer base-images. This may introduce some new errors, but this version is running at my home and it seems to run smoothly.

# OpenEats Project

OpenEats is a recipe management site that allows users to create, share, and store their personal collection of recipes. This fork uses Django Rest Framework as a backend and React (with flux) as a front end.

The usage for the app is intended for a single user or a small group. For my personal use, I would be an admin user and a few (about 5-6) friends and family would be normal users. Admin users can add other users to the project (no open sign-ups), make changes to the available Cuisines and Courses, and add to the homepage banner. Normal users just have the ability to add recipes. Below are a few of the core features the app provides.

- Creating, viewing, sharing, and editing recipes.
- Update Serving information on the fly.
- Browsing and searching for recipes.
- Creating grocery lists.
- Automatically add recipes to your grocery lists.
- Quickly print recipe.
- Linking recipes and ingredient grouping.

### [Read the docs on getting started here!](docs/Running_the_App.md)

If you don't wish to use docker, see installation instructions here:
[Markdown](docs/Running_the_App_Without_Docker.md) OR [Media Wiki!](https://wiki.tothnet.hu/books/other/page/install-openeats-without-docker-and-run-on-apache2)


### [The Update guide can be found here!](docs/Updating_the_App.md)

# Contributing
Please read the [contribution guidelines](CONTRIBUTING.md) in order to make the contribution process easy and effective for everyone involved.

For a guide on how to setup an environment for development see [this guide](docs/Running_the_App_in_dev.md).
