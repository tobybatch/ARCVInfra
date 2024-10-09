
## Create the image

1. Visit https://d-c367049c3f.awsapps.com/start/#/
2. Log in
3. Create a new Redhat instance
4. Set disk size to 30gb
5. Create new key
6. Move key to $HOME/.ssh/arc-provision.pem
7. Launch instance
8. Add ip address to hosts.yaml

## Run the provsioner

```bash
cd path/to/infra/repo/ansible # <--- where that's you checkout of the ARCInfra repo
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/provision.aws.redhat.playbook.yaml -l arcprovision --key-file ~/.ssh/arc-provision.pem --ask-vault-pass
```

## deploy market

```bash
export TAG=1.7.1
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/deploy-vue.playbook.yaml --extra-vars "tag=$TAG" -l arcprovision --key-file ~/.ssh/arc-provision.pem
```