# Developer Helper

This file brings up a set of helper apps that make local development easier if you are using a native PHP stack.

## Services

### MySQL DB 5.7

 * Listening 3336 (so not to clash with a native MySQL DB)
 * Username, password and database name all `lamp`
 * Persistent data in a docker volume

To connect to it using the mysql client in the container use:

 ```bash
 docker compose exec sqldb mysql -ulamp -plamp lamp
 ```

To connect to it using native client use:

```bash
mysql -ulamp -plamp lamp -h 127.0.0.1 -P3336
```

To use SQL Workbench, Jetbrains etc the details are:

 * username: lamp
 * password: lamp
 * database name: lamp
 * root password: notSecureChangeMe
 * host: 127.0.0.1
 * port: 3336

Or as a JDBC URL:

```
jdbc:mysql://127.0.0.1:3336/lamp
```

### Mail catcher

Traps all mail sent to it. You can send mail via SMTP. The server listens on port 1025, and you can view the trapped mail at http://localhost:1080

### PHP My Admin

Popular web based DB admin tool http://localhost:8800

## Laravel .env settings

To use the database bundled here use these settings:

```dotenv
DB_CONNECTION="mysql"
DB_HOST="127.0.0.1"
DB_PORT="3336"
DB_DATABASE="lamp"
DB_PASSWORD="lamp"
DB_USERNAME="lamp"
```

To use the mailtrap bundled here use these settings:

```dotenv
MAIL_HOST="127.0.0.1"
MAIL_PASSWORD="null"
MAIL_PORT="1025"
```

## Overriding ports

The docker compose files supports a dot env file. Create one from the sample in this folder:

```bash
ln -s env.example .env
```

And you can customise the ports.
