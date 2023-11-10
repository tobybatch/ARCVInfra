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


# Execution

All commands are location relative, so before you start:

```bash
cd ansible
```

## Setting up ansible the first time

To release to a given machine you will need set up public key auth with the user specified in [hosts.yml](hosts.yaml). See the [ansible docs](https://docs.ansible.com/ansible/latest/inventory_guide/connection_details.html)

## Passwords

At certain times we need to `sudo` stuff. To provide the sudo password use the `--ask-become-pass` and you will be prompted for the thunder pants password. This is detailed in the [ansible docs, privilege escalation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_privilege_escalation.html#become-command-line-options).

## Vaults

Hey but typing in passwords is for dweebs! Too right kido, we can use a vault to securely store sensitive data and Toby has done just that. Ansible has a secure storage mechanism built in, [ansible docs, vaults](https://docs.ansible.com/ansible/latest/vault_guide/index.html). And now you can drop the `--ask-vault-pass` off the end of the dep[loy and release commands.

In practice this means that if you are on a full disk crypto dev machine you can store the vault password in a file called `.ansible_vault_passwd_file` in the same folder as this readme.

**ONLY DO THIS ON COMPUTERS WITH FULL DISK CRYPTO**

The vault password is in the Neontribe 1pass, or you can ask another developer for it.

## Targets

In both the cases we use `--limit TARGET` means we only release to a single server. [ansible docs, patterns and targeting](https://docs.ansible.com/ansible/latest/inventory_guide/intro_patterns.html#patterns-and-ansible-playbook-flags)

# Specifics and Examples

 * [Deploying](DEPLOY.md) - Features, sprints and hotfixes to staging, and releasing to live
 * [Utils](UTILS.md) - Backups, reseeding DB etc.
