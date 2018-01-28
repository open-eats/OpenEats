# Serving with a proxy server and HTTPS
 By default the docker applacition doesn't come with an https server. It is also likely that you want to server other applcaitions.

 If you want to server the docker applciation via https or serve mutliple appcations via nginx/apache then you will also need a proxy server.

 To change the port from which OpenEats is serverd you will need to update the left side of the port configuration.
 - Open the docker-prod.yml (your docker-compose configuration) file.
 - To serve the app via port 7000:
``` yml
  nginx:
    image: openeats/nginx
    command: ./start.sh
    ports:
      - "7000:80"
    volumes:
      - static-files:/var/www/html/openeats-static/static-files
      - site-media:/var/www/html/openeats-static/site-media
    depends_on:
      - api
      - node
    env_file:
      env_prod.list
```

- Restart you docker containers `docker-compose -f docker-prod.yml restart`
- Load localhost:7000 to confirm it worked.

For free ssl crits see:
https://letsencrypt.org/getting-started/

For more info on how to use proxies, see:
https://www.nginx.com/resources/admin-guide/reverse-proxy/
