# Setting up Ansible

## Ubuntu/Debian/PopOs

    sudo apt python3-is-pyton ansible
    ansible-galaxy collection install community.general

## Centos/Rocky/DeadRat

_NYI_

## MacOs

_NYI_

## Windoze

_NYI_

# Executing

## Preparation

You need to tag the Service repo and create a release. While the tag could be anything it must start with `v`, e.g. `v1.2.3-fc.1`

If you have the github cli installed

```bash
git checkout develop
gh release create v1.2.3-fc.1
```

Otherwise

```bash
git checkout develop && git tag v1.2.3-fc.1
```

Then goto https://github.com/neontribe/ARCVService/releases and create a new pelease.

## Deploying a tag

This **DOES NOT** send the release live. Note the `-l arcstaging` limits the release to the staging server, it's not yet set up for live.

    ansible-playbook -i hosts.yaml deploy-laravel.yml --limit arcstaging --extra-vars "tag=1.14.0" -l vagrant --ask-become-pass

## Sending a release live

Not yet available via ansible.

Shell onto the server, not the tag name should **NOT** have the `v` prefix.

```bash
export TAG=<INSERT TAG NAME HERE>
cd /var/www/ARCVService/releases/ARCVService-${TAG}
rm -rf storage
ln -s /var/www/ARCVService/storage
ln -s /var/www/ARCVService/service_env .env
cd /var/www/ARCVService
rm current_release public_html
ln -s /var/www/ARCVService/releases/ARCVService_v${TAG} current_release
ln -s /var/www/ARCVService/releases/ARCVService_v${TAG}/public public_html
```
