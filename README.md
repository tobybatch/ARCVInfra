sudo apt install vagrant virtualbox python3-is-pyton ansible
ansible-galaxy collection install community.general

ansible-playbook -i hosts.yaml deploy-laravel.yml --limit vagrant --extra-vars "tag=1.14.0" -l vagrant --ask-become-pass
