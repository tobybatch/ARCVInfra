FROM php:8.1-cli

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install bcmath \
    && apt-get update \
    && apt-get install -y --no-install-recommends supervisor

ADD laravel-worker.ini /etc/supervisord.d/laravel-worker.ini
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

ENV APP_ROOT=/opt/project
ENV QUEUE_DRIVER=database
ENV NUM_PROCS=4
ENV OPTIONS=
