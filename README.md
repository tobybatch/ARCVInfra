## Backups

### Requirements

 * SSH Key on the target servers.  I can't get rsync to accept a CLI password.
 * ansible
 * ```export ANSIBLE_VAULT_PASSWORD_FILE=somefile.txt```
 * Put the vault password in somefile.txt

### Run it

    ansible-playbook -i inventory/arc.yml backup.yml

Now check the backups directory for a directory matcing the server name.

## Deploy

### Requirements

 * SSH Key on the target servers.
 * A zip of the code base from https://github.com/neontribe/ARCVService/releases in this directory

### Run it

    ansible-playbook -i inventory/arc.yml --limit=TARGET --extra-vars="archivename=ARCVService-1.2.0.zip" deploy.yaml

### Vagrant

There is a vagrant test env.

    vagrant up
    ssh-copy-id neontribe@192.168.13.191
    ansible-playbook -i inventory/arc.yml --limit=vagrant --extra-vars="archivename=ARCVService-1.2.0.zip" deploy.yaml
