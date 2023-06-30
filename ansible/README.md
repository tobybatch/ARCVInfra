# Setting up Ansible

## Installation

### Ubuntu/Debian/PopOs

    sudo apt python3-is-pyton ansible
    ansible-galaxy collection install community.general

### Centos/Rocky/DeadRat

_NYI_<-- Neil?

### MacOs

_NYI_ <-- Leanne?

### Windoze

_NYI_ <-- Nick?

## Secrets and Vaults

The `become` password for privilege escalation can be passed at runtime using `--ask-become-pass`.

On a dev workstation with full disk crypto it is acceptable to store the vault password locally. Create a file called `.ansible_vault_passwd_file` and place the vault password in it as plaint text:

```bash
echo "THE VALUT PASSWORD" > .ansible_vault_passwd_file
```

The vault password is in the "Neontribe 1pass" under ARC vault password

# Preparation

You need to tag the Service or Market repo and create a release. While the tag could be anything it must start with `v`, e.g. `v1.2.3-fc.1`

If you have the github cli installed

```bash
git checkout develop
gh release create v1.2.3-fc.1
git push --tags
```

Otherwise

```bash
git checkout develop && git tag v1.2.3-fc.1
git push --tags
```

Then goto [Service](https://github.com/neontribe/ARCVService/releases) or [Market](https://github.com/neontribe/ARCVMarket/releases) and create a new release.

# Execution

To release toa given machine you will need set up public key auth with the user specified in [hosts.yml](hosts.yaml). See the [ansible docs](https://docs.ansible.com/ansible/latest/inventory_guide/connection_details.html)

In both the cases we use `-l arcstaging` means we only release to the staging server.

In both cases you will need the thunder pants password.

 * [Market](DEPLOY_VUE.md)
 * [Service/Store](DEPLOY_LARAVEL.md)
