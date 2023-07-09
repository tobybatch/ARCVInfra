# Deploying a tag

This **DOES NOT** send the release live. Note the `-l arcstaging` limits the release to the staging server, it's not yet set up for live.

First tag the repo

    export TAG="v1.2.3-fc.1"
    git checkout develop
    gh release create --generate-notes $TAG

This one goes to staging:

    ansible-playbook -i hosts.yaml -i vault.yml deploy-laravel.yml --extra-vars "tag=$TAG" -l arcstaging

# Sending a release live

    ansible-playbook -i hosts.yaml -i vault.yml release-laravel.yml --extra-vars "tag=$TAG" -l arcstaging
