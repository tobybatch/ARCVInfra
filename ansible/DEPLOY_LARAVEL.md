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

    ansible-playbook -i hosts.yaml -i vault.yml release-laravel.yml --extra-vars "tag=1.16.0-rc.3" -l vagrant
