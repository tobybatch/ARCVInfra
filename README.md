- [Install](#install)
  * [The inventory files(s)](#the-inventory-files-s-)
    + [Inventory file structure](#inventory-file-structure)
      - [Live](#live)
      - [Skunk](#skunk)
- [Backups](#backups)
  * [Requirements](#requirements)
  * [Run it](#run-it)
- [Deploy](#deploy)
  * [Requirements](#requirements-1)
  * [Run it](#run-it-1)
    + [Individual variables](#individual-variables)
  * [Vagrant](#vagrant)

## Install

To install for testing/workstation use:

    git clone --recurse-submodules https://github.com/tobybatch/ARCVInfra.git /opt/ARCVInfra
    apt install ansible

To set this up as an autonomous back-up golem we need to set it's install location.

    git clone --recurse-submodules https://github.com/tobybatch/ARCVInfra.git /opt/ARCVInfra
    apt install ansible
    cd /opt/ARCVInfra
    # Optional actions if you want cron and logrotate
    sudo ln -s /opt/ARCVInfra/cron.daily /etc/cron.daily/ARCVInfra
    sudo ln -s /opt/ARCVInfra/cron.weekly /etc/cron.weekly/ARCVInfra
    sudo ln -s /opt/ARCVInfra/cron.monthly /etc/cron.monthly/ARCVInfra
    sudo ln -s /opt/ARCVInfra/logrotate /etc/logrotate.d/ARCVInfra

The cron scripts expect to run as neontribe, so you'll need to create and install some keys and vault passwords.

    sudo echo horsestablevaultbattery > /etc/ansible/vault_pass
    sudo chown neontribe:root /etc/ansible/vault_pass
    sudo chmod 440 /etc/ansible/vault_pass
    sudo chown -R neontribe:neontribe /opt/ARCVInfra
    sudo su - neontribe
    ssh-keygen
    ssh-copy-id neontribe@178.62.68.36
    ssh-copy-id neontribe@46.101.18.83

### The inventory files(s)

Ansible holds encrypted secrets in the inventory file (```inventory/arc.yml```).  This see [here](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html) for details about setting up vault passwords.

Andy and Toby have the password.

tldr; ```export ANSIBLE_VAULT_PASSWORD=HORSEVAULTSTABLEBATTERY```

Now you can run all the vault commands without entering the password every time.

    ansible-vault edit inventory/arc.yml

#### Inventory file structure

The top level keys are mandated by ansible, ```all:children``` under this are two sections.

##### Live

These are the servers that will be backed up by the ```backup.yaml``` playbook.  For each server listed there (```arc_live``` and ```arc_staging```) there are a number of keys.

    ansible_ssh_host: a.b.c.d                 # ip address or fqdn of the remote host
    ansible_ssh_user: username                # user to connect as, must be able to read all files
    ansible_become_pass: password             # password to use for escalation (sudo)
    arc_vouchers_install_path: /path/to/app   # the root of the install
    arc_vouchers_env_path: /home/username/env # the path to the .env file for this app
    arc_mysql_user: mysql_username            # mysql user name
    arc_mysql_pass: mysql_password            # mysql password
    arc_mysql_name: mysql_database_name       # mysql database name

##### Skunk

These are taget machines that can be used for deployments.  At the moment it contains a test vagrant machine that won't do the SSL setup as it can't resolve the certbot commands.  The second is a testing machine that will need some set up before it can be used again.

    ansible_ssh_host: a.b.c.d                 # ip address or fqdn of the remote host
    ansible_ssh_user: username                # user to connect as, must be able to read all files
    ansible_become_pass: password             # password to use for escalation (sudo)
    mysql_root_pass: password                 # mysql root password, to create the DB if needed
    arc_mysql_user: mysql_username            # mysql user name 
    arc_mysql_pass: mysql_password            # mysql password
    arc_mysql_name: mysql_database_name       # mysql database name
    arc_version: v1.2.3                       # The version to fetch from github (https://github.com/neontribe/ARCVService/releases)
    arc_source: arc_live                      # The backup to deploy, ```ls backups```
    arc_domainname: domain.name               # The doimain name to use to set up the vhost for vhost switching 
    protocol: https                           # https|http if you choose https then the domain above should resolve to the ip of the server or certbot will fail
    certbot_mail: sample@example.com          # The email to use for the certbot registration

## Backups

### Requirements

 * SSH Key on the target servers.  I can't get rsync to accept a CLI password.
 * ansible on the local machine
 * python on the remote machine
 * ```export ANSIBLE_VAULT_PASSWORD_FILE=somefile.txt```
 * Put the vault password, the inventory section above
 * The password is known to Andy and Toby

### Run it

This will backup the live and staging server.  Edit the inventory file to add another server under the ```all:children:hosts:live``` key to backup an additional machine.

    ansible-playbook -i inventory/arc.yml --ask_vault-pass backup.yml

Now check the backups directory for a directory matcing the server name.

## Deploy

The deployment script will provision a bare metal server ready for laravel/arc.  Grab a release from github and build it onto that server.  It will import data and setup from a backup made by the section above.

### Requirements

 * Tested on an Ubuntu 18.04
 * On the server ```apt install python```
 * SSH Key on the target servers
 * Either edit the inventory to add a new entry or override the variables on the CLI.

### Run it

    ansible-playbook -i inventory/arc.yml --limit=TARGET deploy.yaml

#### Individual variables

Individual variables can be overriden on CLI but really, it's easier to create a new inventory, create the keys ```all:children:skunk:hosts:MYSERVER``` and create the varaibe there.  Then you can point to a different inventiry when you run the playbook.

    ansible-playbook -i inventory/MYINVENTORY.yml deploy.yaml

If you want to experiment with other overrides then it look something a bit like this (it's untested):

    ansible-playbook \
        -i '192.168.13.191,' \ # to use an ip add a trailing comma
        --user tobias \
        --ask-become-pass \
        --ask-pass \
        --extra-vars="arc_domainname=foo.com,protocol=http" \
    deploy.yaml

### Vagrant

There is a vagrant test env.

    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant deploy.yaml
