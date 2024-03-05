# Utils

## Backup the DB

### Staging

```shell
ansible-playbook -i hosts.yaml -i vault.yml --ask-vault-pass reseed-staging.yml -l arcstaging
```

### Live

```shell
ansible-playbook -i hosts.yaml -i vault.yml --ask-vault-pass reseed-staging.yml -l arclive
```

### Both

```shell
ansible-playbook -i hosts.yaml -i vault.yml --ask-vault-pass reseed-staging.yml
```

## Reseed staging

This should refuse to run on prod but **be careful**

```shell
ansible-playbook -i hosts.yaml -i vault.yml --ask-vault-pass dump-db.yml -l arcstaging
```

## Monthly maintenance

```shell
ansible-playbook -i hosts.yaml -i vault.yml monthy-maintenance.yml
```