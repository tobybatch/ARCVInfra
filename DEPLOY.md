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

    vagrant box update
    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant deploy.yaml


#### Deploy a test server to vagrant


    vagrant box update
    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant deploy.yaml

#### Deploy a test server of version 1.5 to vagrant

    vagrant box update
    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant --extra-vars="arc_version=v1.5.0" deploy.yaml

#### Deploy a test server at commit hash d2c99c89c62aae12f5e7e75647fb4cb19dd88745

This is a specific PR commit hash.

    vagrant box update
    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant --extra-vars="arc_commit_hash=d2c99c89c62aae12f5e7e75647fb4cb19dd88745" deploy.yaml
