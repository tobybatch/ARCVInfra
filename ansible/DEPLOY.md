# Staging

## Deploying development snapshots for testing

USE DOCKER

## Deploying a feature(s) to staging

At the end of a sprint or piece of work we will have a feature or number of features that are in develop and need to be released to staging. We should been working in branches off develop , raising PRs and merging back into develop, so develop now holds our up to date code. We want to release this so we need to update main, tag main, and then release. This code should be an exact match to what will be released to live, so we'll merge into main.

**Should this require a PR?** - Not sure it does as we should never get conflicts or issues as shold never have merged into main unless it's a hotfix, and that should get cherry picked or back merged into develop.

```shell
cd path/to/repo #  <--- where that's your code is, either service or market
git checkout develop
git pull origin develop
git checkout main
git pull origin main
git merge develop
```

## Deploying a hotfix to staging

A hot fix should be branched off main and worked on, then it will be merged back into main and that fix cherry-picked into develop. This way the patch is guarnteed to be tested against the main (live) branch and included in the future develop releases. See [here](https://github.com/neontribe/ARCVService#versioning-branching-and-tags) for details on how branching and development should work.

```shell
cd path/to/repo #  <--- where that's your code is, either service or market
git checkout MY-HOTFIX-BRANCH
git pull origin MY-HOTFIX-BRANCH
git checkout main
git pull origin main
git merge MY-HOTFIX-BRANCH
```

Now the merge into develop by raising a PR for the hotfix branch back into develop.

## Tag and deploy

Now we can tag the repo, ensure we are on the main branch

```shell
git checkout main && git pull origin main
export TAG="1.2.3-fc.1" # DO NOT ADD THE `v` AT THE FRONT
gh release create --generate-notes $TAG
```

If you now check github you'll have a new release with release notes, cool huh?

Now we can deploy service to staging:

```shell
cd path/to/infra/repo/ansible <--- where that's you checkout of the ARCInfra repo
ansible-playbook -i hosts.yaml -i vault.yml deploy-laravel.yml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

Now we can deploy market to staging:

```shell
cd path/to/infra/repo/ansible <--- where that's you checkout of the ARCInfra repo
ansible-playbook -i hosts.yaml -i vault.yml deploy-vue.yml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

**THE RELEASE IS NOT YET LIVE**

At this point you can shell onto the server and check the deployment.

# Releasing to staging

Releases are managed by symlinking files into the correct location:

Releasing service:

```shell
ansible-playbook -i hosts.yaml -i vault.yml release-laravel.yml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

Releasing market:

```shell
ansible-playbook -i hosts.yaml -i vault.yml release-vue.yml --extra-vars "tag=$TAG" -l arcstaging --ask-vault-pass
```

# Deploy and releasing to live

Releases to live should **always** be a replication of code that was release to staging, so the tagging bit of the release is not needed. We cat check the tag by looking in the file `version.txt` in the root of the release.

```shell
export TAG="1.2.3-fc.1"

# deploy service
ansible-playbook -i hosts.yaml -i vault.yml deploy-laravel.yml --extra-vars "tag=$TAG" -l arclive --ask-vault-pass

# deploy market
ansible-playbook -i hosts.yaml -i vault.yml deploy-vue.yml --extra-vars "tag=$TAG" -l arclive --ask-vault-pass

# release service
ansible-playbook -i hosts.yaml -i vault.yml release-laravel.yml --extra-vars "tag=$TAG" -l arclive --ask-vault-pass

# release market
ansible-playbook -i hosts.yaml -i vault.yml release-vue.yml --extra-vars "tag=$TAG" -l arclive --ask-vault-pass
```















