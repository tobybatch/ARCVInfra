
## Create the image

1. Visit https://d-c367049c3f.awsapps.com/start/#/
2. Log in
3. Create a new Redhat instance
4. Set disk size to 30gb
5. Create new key
6. Move key to $HOME/.ssh/arc-provision.pem
7. Launch instance
8. Add ip address to hosts.yaml
9. Set the ansibile vault password in `.ansible_vault_passwd_file` (it's in the DXW 1Pass), or append `--ask-vault-pass` to the end of the cammands
10. Change directory to this folder

## Run the provisioner

```bash
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/provision.aws.redhat.playbook.yaml -l arcprovision --key-file ~/.ssh/arc-provision.pem
```

## Set the tags to deploy

```bash
export MARKET_TAG=1.7.1
export SERVICE_TAG=1.16.8
```

## deploy market

```bash
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/deploy-vue.playbook.yaml --extra-vars "tag=$MARKET_TAG" -l arcprovision --key-file ~/.ssh/arc-provision.pem
```

## deploy service

```bash
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/deploy-laravel.playbook.yaml --extra-vars "tag=$SERVICE_TAG" -l arcprovision --key-file ~/.ssh/arc-provision.pem
```

## release market:

```bash
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/release-vue.playbook.yaml --extra-vars "tag=$MARKET_TAG" -l arcprovision --key-file ~/.ssh/arc-provision.pem
```

## release service:

```bash
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/release-laravel.playbook.yaml --extra-vars "tag=$SERVICE_TAG" -l arcprovision --key-file ~/.ssh/arc-provision.pem
```
