# Utils

## Backup the DB

### Staging

```shell
ansible-playbook -i hosts.yaml -i vault.yaml --ask-vault-pass playbooks/dump-db.yaml -l arcstaging
```

### Live

```shell
ansible-playbook -i hosts.yaml -i vault.yaml --ask-vault-pass playbooks/dump-db.yaml -l arclive
```

### Both

```shell
ansible-playbook -i hosts.yaml -i vault.yaml --ask-vault-pass playbooks/dump-db.yaml
```

## Reseed staging

This should refuse to run on prod but **be careful**

```shell
ansible-playbook -i hosts.yaml -i vault.yaml --ask-vault-pass playbooks/reseed-staging.yaml -l arcstaging
```

## Monthly maintenance

```shell
ansible-playbook -i hosts.yaml -i vault.yaml playbooks/monthy-maintenance.yaml
```
