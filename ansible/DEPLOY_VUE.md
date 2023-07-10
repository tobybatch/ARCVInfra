# Deploying a tag

This **DOES NOT** send the release live. Note the `--limit arcstaging` limits the release to the staging server, it's not yet set up for live.

    export TAG=1.7.0-rc.1 # DO NOT ADD THE `v` TO THE TAG
    ansible-playbook -i hosts.yaml -i vault.yml deploy-vue.yml --extra-vars "tag=$TAG" --limit arcstaging

## Sending a release live

# Sending a release live

    export TAG=1.7.0-rc.1
    ansible-playbook -i hosts.yaml -i vault.yml release-vue.yml --extra-vars "tag=$TAG" --limit arcstaging
