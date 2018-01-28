# Backing up Your Data

The following commands can be used to take backups of your data. These commands are automatically run when you upgrade to a newer version as well.


#### Backing up recipes images:

Replace `/dir/on/local/system/` with the location where you would like your images.
```sh
docker cp openeats_api_1:/code/site-media/ /dir/on/local/system/
```

#### Backing up database:

Places a sql dump of the database on your current working directory.
```sh
docker exec openeats_db_1 sh -c 'exec mysqldump openeats -uroot -p"$MYSQL_ROOT_PASSWORD"' > openeats.sql
```
