# Deploying a tag

This **DOES NOT** send the release live. Note the `-l arcstaging` limits the release to the staging server, it's not yet set up for live.

First tag the repo
    
    git checkout develop
    gh release create v1.2.3-fc.1
    git push --tags

Then deploy it, this one goes to a local vagrant machine

    ansible-playbook -i hosts.yaml -i vault.yml deploy-laravel.yml --extra-vars "tag=1.16.0-rc.3" -l vagrant

This one goes to staging:

    ansible-playbook -i hosts.yaml -i vault.yml deploy-laravel.yml --extra-vars "tag=1.16.0-rc.3" -l arcstaging

# Sending a release live

Not yet available via ansible.

Shell onto the server, not the tag name should **NOT** have the `v` prefix.

```bash
export TAG=<INSERT TAG NAME HERE>
cd /var/www/ARCVService/releases/ARCVService-${TAG}
rm -rf storage
ln -s /var/www/ARCVService/storage
ln -s /var/www/ARCVService/service_env env
cd /var/www/ARCVService
rm current_release public_html
ln -s /var/www/ARCVService/releases/ARCVService_v${TAG} current_release
ln -s /var/www/ARCVService/releases/ARCVService_v${TAG}/public public_html
```
