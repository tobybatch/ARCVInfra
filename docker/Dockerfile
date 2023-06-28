# Source base [fpm/apache]
ARG BASE="fpm"
ARG PHP_VER="8.1"
ARG COMPOSER_VER="latest"
# Branch name
ARG BRANCH="main"
# Timezone for images
ARG TIMEZONE="Europe/Berlin"

###########################
# Shared tools
###########################

# full source
FROM alpine:latest AS git
ARG BRANCH
ARG TIMEZONE
RUN apk add --no-cache git && \
    git clone --depth 1 --branch ${BRANCH} https://github.com/neontribe/ARCVService.git /opt/project


FROM tobybatch/php:8.1-${BASE} as dev
LABEL maintainer="tobias@neontribe.co.uk"
RUN apt update && apt -y upgrade && \
    apt install -y \
    git default-mysql-client acl gnupg2 \
    touch .env
ENV COMPOSER_HOME=/composer
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV DATABASE_URL="sqlite://tmp/db.sqlite3"
RUN echo xdebug.mode=develop,debug >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo xdebug.client_host=host.docker.internal >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo xdebug.start_with_request=yes >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN composer install --dev
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN /opt/project/docker/yarn-install.sh
# set app env
# bump memlimit

FROM dev as prod
# clear xdenug
# ? drop mem limit
# set app env

LABEL maintainer="tobias@neontribe.co.uk"


























FROM builder as final

ENV CURRENT_UID 33

ENV APP_DEBUG true
ENV APP_ENV local
ENV APP_KEY base64:5/euYB2rELcumOH7lKf8aOd4aOb5GAO6J/I1ykDDIPk:
ENV APP_LOG_LEVEL debug
ENV APP_NAME ARCVService
ENV APP_SEEDS 'Dev'
ENV APP_TIMEZONE Europe/London
ENV APP_URL http://0.0.0.0:8000
ENV APP_VER 1.9.0
ENV ARC_MARKET_URL https://voucher-staging.alexandrarose.org.uk
ENV ARC_SCHOOL_MONTH 9
ENV ARC_SERVICE_DOMAIN arcv-service.test
ENV ARC_STORE_DOMAIN arcv-store.test
ENV BROADCAST_DRIVER log
ENV CACHE_DRIVER file
ENV DB_CONNECTION mysql
ENV DB_DATABASE lamp
ENV DB_HOST db
ENV DB_PASSWORD lamp
ENV DB_PORT 3306
ENV DB_USERNAME lamp
ENV MAIL_DRIVER log
ENV MAIL_ENCRYPTION null
ENV MAIL_FROM_ADDRESS from@example.com
ENV MAIL_FROM_NAME 'Mailer Name'
ENV MAIL_HOST smtp.mailtrap.io
ENV MAIL_PASSWORD null
ENV MAIL_PORT 2525
ENV MAIL_TO_ADMIN_ADDRESS to@example.com
ENV MAIL_TO_ADMIN_NAME 'Admin Name'
ENV MAIL_TO_DEVELOPER_NAME 'User Support'
ENV MAIL_TO_DEVELOPER_TEAM arc@neontribe.co.uk
ENV MAIL_USERNAME null
ENV PASSWORD_CLIENT 1
ENV PASSWORD_CLIENT_SECRET secret
ENV QUEUE_DRIVER sync
ENV SESSION_DRIVER file
ENV SESSION_SECURE_COOKIE false

WORKDIR /opt/project

ENTRYPOINT /opt/project/.docker/docker-entrypoint.sh
