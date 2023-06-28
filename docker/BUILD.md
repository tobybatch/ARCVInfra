neontribe/arc:apache-dev
neontribe/arc:apache-prod
neontribe/arc:fpm-dev
neontribe/arc:fpm-prod

docker build -t neontribe/arc:apache-dev -e BASE=apache TARGET=dev .
docker build -t neontribe/arc:apache-prod -e BASE=apache TARGET=prod .
docker build -t neontribe/arc:fpm-dev -e BASE=fpm TARGET=dev .
docker build -t neontribe/arc:fpm-prod -e BASE=fpm TARGET=prod .