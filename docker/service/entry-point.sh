#!/bin/bash -x

function checkDatabase() {
  echo "Wait for MySQL DB connection ..."
  until php /dbtest.php "$DB_HOST" "$DB_DATABASE" "$DB_PORT" "$DB_USERNAME" "$DB_PASSWORD"; do
    echo Checking DB: $?
    sleep 3
  done
  echo "Connection established"
}

function handleStartup() {
  # in production we will have a .env mounted into the container, this will have (at least) a
  # APP_KEY, if we don't have a .env we will create one
  if [ ! -e /opt/project/.env ]; then
    if [ "$APP_ENV" == "prod" ]; then
      echo "No .env file present."
      echo "Your are running a prod environment version but there is no .env file present"
      echo "You need to mount one into this container or the system cannot proceed."
      exit 1
    fi
    grep APP_KEY .env
    # shellcheck disable=SC2181
    if [ "$?" != 0 ]; then
      echo "APP_KEY=''" > .env
      php /opt/project/artisan key:generate
    fi
  fi

  # These are idempotent, run them anyway
  php /opt/project/artisan migrate
  chmod 600 /opt/project/storage/*.key

  # If this is the first run, we won't
  grep PASSWORD_CLIENT_SECRET .env > /dev/null
  # shellcheck disable=SC2181
  if [ "$?" != 0 ]; then
    echo -n PASSWORD_CLIENT_SECRET= >> /opt/project/.env
    php artisan passport:install|tail -n1|awk '{print $3}'>>.env
  fi

  if [ -e /docker-entrypoint-initdb.d ]; then
    for filename in /docker-entrypoint-init.d/*; do
      if [ "${filename##*.}" == "sh" ]; then
        # shellcheck disable=SC1090
        source /docker-entrypoint-initdb.d/"$filename"
      fi
    done
  fi

  export LOG_CHANNEL=stderr
}

checkDatabase
handleStartup
exec php-fpm
exit