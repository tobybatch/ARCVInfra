# -*- mode: ruby -*-
# vi: set ft=ruby :

# Testing vagrant machine, se we can test deploys locally

Vagrant.configure("2") do |config|
    config.vm.define "arctest" do |arctest|
        arctest.vm.box = "rockylinux/9"
        arctest.vm.hostname = 'arctest'

        arctest.vm.network "private_network", ip: "192.168.56.191"
        arctest.vm.synced_folder '.', '/vagrant', disabled: true

        arctest.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "arctest"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end

        arctest.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"

        arctest.vm.provision "shell", inline: <<-SHELL
            dnf update
            dnf install -y httpd php php-{common,devel,pear,cgi,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip}
            pecl install libsodium
            php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
            php composer-setup.php
            php -r "unlink('composer-setup.php');"
            mv composer.phar /usr/local/bin/composer
            useradd neontribe -G 10 -p'$6$jxY9rioiXVJDR0dS$xvyvT6SInZIlPgQsECgn9KMm37VVwNfpwvSgDLVgfyRbpLfjmWzlLAvcgQjyyxsLHJXTaSr.I9AsK21Eoj6uM0' || true
            mkdir -p /home/neontribe/.ssh
            echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/dxFUsOQ730CYMH8D4zLlUGrtC5CkkTK6tnKt9FvosmB/zRPh6A5CkveVWzHBWUq5o4LnREh/V5ov1sA2rkdJ8y6NA+obI1jL7UY/eiH7wPlvBKkNAx65WXCcsBYF3TAMkUROUMy8PB6+17f/zLjLvWQTkrzet+ptfdsKdIJqKPxWQy1JcSvukcG/VU9RWTwGY7kvWRF8dxJHWE3LUKbJiNq6xGOLsPI25fkjwW+sBi5Nmcononz3XToHtD5bl76SnlHQ43auaxp4IMPQkcLz5sZTstKxkPmBY+kUL6U9GnYc+QcxCV35H8f8wH8DfxivledBUo6gHzjEzh34s67hwlfzxkuH/DYO247XlPLxm0oPJuANzDlYdY8ly52CCPDX9sFa1mLGtP3mpp+yhTRA5M/IrPolqBDn7C3BV79GyVjB4Z6yZiRJlsaqGwxHl46wNKSA0UOjZm2DaPuFXFVHGYxwuc50a4zLGTCmQC4gmb+kKHcWtHlZ02fUUN3uxXy+1Ok+HEU9XqI3PjfrftKGkc1FGDLjD2h4I8ulPIbPslVxt8iieazAEwacGlGFHoLUSbu5l7gYjuTmCHS+kP9/vQT8n2RCU7l7PH3rQYjvWZ1RQzWrPeNeJTjmSxE1LZ/rYUV/MEBdFcBqIH4g2e+tb++x8vfzw77g6Crky2n/SQ== tobias@tobias" > /home/neontribe/.ssh/authorized_keys
            chown -R neontribe:neontribe /home/neontribe/
            chmod 700 /home/neontribe/.ssh
            chmod 600 /home/neontribe/.ssh/authorized_keys
            echo "+------------------------------------------+"
            echo "| Neontribe user created, password set to: |"
            echo "|     changeme                             |"
            echo "+------------------------------------------+"
            echo "eth1 ip address: $(ip -4 addr)"
        SHELL

        #Dir.glob("~/.ssh/*.pub") do |pubkey|
        #    arctest.vm.provision "file", source: pubkey, destination: pubkey
        #    arctest.vm.provision "shell", inline: <<-SHELL
        #        cat  #{pubkey} >> /home/neontribe/.ssh/authorized_keys
        #    SHELL
        #end
    end

end
