# Deploying a tag

This **DOES NOT** send the release live. Note the `-l arcstaging` limits the release to the staging server, it's not yet set up for live.

    ansible-playbook -i hosts.yaml deploy-laravel.yml --limit arcstaging --extra-vars "tag=1.16.0-rc.1" -l arcstaging --ask-become-pass

# Sending a release live

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
