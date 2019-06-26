## Backups

### Requirements

 * SSH Key on the target servers.  I can't get rsync to accept a CLI password.
 * ansible
 * ```export ANSIBLE_VAULT_PASSWORD_FILE=somefile.txt```
 * Put the vault password in somefile.txt
 * The password is 

### Run it

This will backup the live and staging server.  Edit the inventory file to add another server under the ```all:children:hosts:live``` key to backup an additional machine.

    ansible-playbook -i inventory/arc.yml backup.yml

Now check the backups directory for a directory matcing the server name.

## Deploy

The deployment script will provision a bare metal server ready for laravel/arc.  Grab a release from github and build it onto that server.  It will import data and setup from a backup made by the section above.

### Requirements

 * Tested on an Ubuntu 18.04
 * On the server ```apt install python```
 * SSH Key on the target servers
 * Either edit the inventory to add a new entry or override the variables on the CLI.

### Inventory details

### Run it

    ansible-playbook -i inventory/arc.yml --limit=TARGET --extra-vars="archivename=ARCVService-1.2.0.zip" deploy.yaml

### Vagrant

There is a vagrant test env.

    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant deploy.yaml
