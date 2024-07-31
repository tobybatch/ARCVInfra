# Staging

## Deploying development snapshots for testing

USE DOCKER, Docs NYI

## Deploying a release candidate to staging

During a sprint or as the result of a hotfix we need to release a tag to staging. In the following example it an RC release, the tag name doesn't master.

Deploying service

```shell
export TAG=1.17.2-rc3
cd path/to/infra/repo/ansible <--- where that's you checkout of the ARCInfra repo
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/deploy-laravel.yaml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

Deploying market

```shell
export TAG=1.17.2-rc3
cd path/to/infra/repo/ansible <--- where that's you checkout of the ARCInfra repo
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/deploy-vue.yaml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

**THE RELEASE IS NOT YET LIVE**

At this point you can shell onto the server and check the deployment. Whn you are happy you can release it:

Releasing service:

```shell
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/release-laravel.yaml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

Releasing market:

```shell
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/release-vue.yaml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

## Creating a full release

Now we can tag the repo, ensure we are on the main branch

```shell
git checkout main && git pull origin main
export TAG="1.2.3-fc.1" # DO NOT ADD THE `v` AT THE FRONT
gh release create --generate-notes $TAG
```

If you now check github you'll have a new release with release notes, cool, huh? You can [release that to staging](#deploying-a-release-candidate-to-staging) whenever you want.

# Deploy and releasing to live

Live releases are still done by hand :( 

Containerisation will make this process redundant.
