# Backing up Your Data

The following commands can be used to take backups of your data and restore those backups. The backup commands are automatically run when you upgrade to a newer version as well.


### Recipes Images

#### Backing up:

Replace `/dir/on/local/system/` with the location where you would like your images.
```sh
docker cp openeats_api_1:/code/site-media/ /dir/on/local/system/
```

#### Restoring:

Replace `/dir/on/local/system/` with the location where you would like your images.
```sh
docker cp /dir/on/local/system/site-media/. openeats_api_1:/code/site-media/ 
```

### Database

#### Backing up:

Places a sql dump of the database on your current working directory.
```sh
docker exec openeats_db_1 sh -c 'exec mysqldump openeats -uroot -p"$MYSQL_ROOT_PASSWORD"' > openeats.sql
```

#### Restoring:

First cd into the dir that contains your sql backup. Once there you need to source your env file so you don't have to type your database password on the command line. Then run the last command to start the restore.
Note: if you changed the database name then you will need to change the last word the statement below to the database name you gave OpenEats.
```sh
cd /open/eats/root/
source env_prod.list
cat openeats.sql | docker exec -i openeats_db_1 /usr/bin/mysql -u root -p"$MYSQL_ROOT_PASSWORD" openeats

```


### Sources
- [Copying Image Files to and from Docker Containers/Volumes](https://gist.github.com/spalladino/6d981f7b33f6e0afe6bb)
- [DB backups/restores](https://stackoverflow.com/questions/22907231/copying-files-from-host-to-docker-container)
