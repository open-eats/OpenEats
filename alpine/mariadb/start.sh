#!/usr/bin/env sh

# mariadb
/startup/create-database.sh

# NGINX doesn't let you use ENV vars within the conf file.
# We use sed to set the env vars we need.
# Sed replace the API_PORT vars.

sed -i "s/API_HOST/$API_HOST/g" /etc/nginx/conf.d/default.conf;
sed -i "s/API_PORT/$API_PORT/g" /etc/nginx/conf.d/default.conf;

# Start the NGINX service.

nginx -g "daemon off;" &

#!/usr/bin/env sh

# Start the api
# Update the DB if it needs it and compile static files.
/code/manage.py migrate --no-input
/code/manage.py collectstatic --no-input

cat <<EOF | python /code/manage.py shell
from django.contrib.auth import get_user_model
User = get_user_model()
User.objects.filter(is_superuser=True).exists() or \
    User.objects.create_superuser("$SUPERUSER_NAME", "", "$SUPERUSER_PASSWORD")
EOF

# Start up gunicorn
/code/base/gunicorn_start.sh
