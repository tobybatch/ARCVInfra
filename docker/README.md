# Dockers

## Installation

## Install docker desktop

Docker containers are available for Windows, Mac and Linux. Install instructions are here: [docker-composer](https://docs.docker.com/compose/install/). This guide will assume you have followed [Scenario one: Install Docker Desktop](https://docs.docker.com/compose/install/#scenario-one-install-docker-desktop).

## Neontribe private registry

The ARCV project is open source but the board of trustees do not currently want the images publicly available on dockerhub. So circumvent this we have set up a registry at http://192.168.21.97:5000/. To access this you will need to be on the Neontribe VPN. Currently, we haven't set hti sup as a secure registry, so you will need to tell Docker to allow insecure access.

If you are using docker desktop this can be set via the UI. Go to the whale in the taskbar > (Change) Settings > Docker Engine

There maybe an existing jsn file there, you need to add an entry for our server, e.g.

```json
{
  "insecure-registries" : ["192.168.21.97:5000"]
}
```

If you are using the linux daemon installation this fil can be found at `/etc/docker/daemon.json` or overridden for a single user at `~/.config/docker/daemon.json` .

## Tear up for training/demo

Just clone this repo, change directory to this directory and start docker compose:

```bash
git clone https://github.com/neontribe/ARCVInfra.git
cd ARCVInfra/docker
docker compose up # for some installs this may be docker-compose up
```

You will need to update your [hosts file](https://www.liquidweb.com/kb/edit-hosts-file-macos-windows-linux/) and ensure following line is present:

```hosts
127.0.0.1 arcv-service.test arcv-store.test arcv-market.test
```

When that is don you can access the [Service](http://arcv-service.test), [Store](http://arcv-store.test) or [Market](http://arcv-market.test).

Use `ctrl-c` to stop and kill this install. To reset the data:

```bash
docker-compose down --rmi all --volumes
```

## Running as a developer

### Market

Checkout the market repo, cd into it, build it:

```bash
git clone git@github.com:neontribe/ARCVMarket.git
cd ARCVMarket
docker build -t arc-market:dev --target=dev .
```

And the run it (on Linux/OSx), changes on your local file system wil be reflected in the running instance of the market.

```bash
docker run -ti --rm -p 8081:8081 -v $(pwd):/opt/project --user ${UID} arc-market:dev
```

The running instance will be available at http://localhost:8081/

### Service/Store

The service and the store need to have a hostname set to switch them, you will need to update your [hosts file](https://www.liquidweb.com/kb/edit-hosts-file-macos-windows-linux/) and ensure following line is present:

```hosts
127.0.0.1 arcv-service.test arcv-store.test arcv-market.test
```

By far the simplest way to run a dev instance is to use the `docker-compose.yml` file in the `.docker` folder of the service repo. The first time this runs it will take a little time as it builds a local development image. 

```bash
git clone git@github.com:neontribe/ARCVService.git
cd ARCVService
docker compose -f .docker/docker-compose.yml up
```
