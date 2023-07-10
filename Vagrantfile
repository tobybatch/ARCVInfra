# -*- mode: ruby -*-
# vi: set ft=ruby :

# Testing vagrant machine, se we can test deploys locally

Vagrant.configure("2") do |config|
    config.vm.define "arctest" do |arctest|
        arctest.vm.box = "ubuntu/jammy64"
        arctest.vm.hostname = 'arctest'

        arctest.vm.network "private_network", ip: "192.168.56.191"
        config.vm.network "forwarded_port", guest: 80, host: 7999
        arctest.vm.synced_folder '.', '/vagrant', disabled: true

        arctest.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--memory", 1024]
            v.customize ["modifyvm", :id, "--name", "arctest"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end

        arctest.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
        arctest.vm.provision "file", source: "assets/docker-compose.yml", destination: "/tmp/docker-compose.yml"
        arctest.vm.provision "file", source: "assets/node.sh", destination: "/tmp/node.sh"
        arctest.vm.provision "file", source: "assets/env", destination: "/tmp/service_env"
        arctest.vm.provision "file", source: "assets/grants.sql", destination: "/tmp/grants.sql"
        arctest.vm.provision "file", source: "assets/apache-sites.conf", destination: "/tmp/arc.conf"
        arctest.vm.provision "file", source: "assets/htaccess", destination: "/tmp/htaccess"

        arctest.vm.provision "shell", inline: <<-SHELL
            mkdir -p /opt /var/www/ARCVService/ /docker-entrypoint-initdb.d
            cp /tmp/docker-compose.yml /opt/docker-compose.yml
            cp /tmp/service_env /var/www/ARCVService/service_env
            cp /tmp/grants.sql /docker-entrypoint-initdb.d/grants.sql

            apt update
            apt upgrade -y
            apt install -y apache2 git php mysql-client libapache2-mod-php php-mbstring php-cli php-json php-xml php-bcmath php-zip php-pdo php-common php-tokenizer php-mysql composer libsodium-dev docker.io docker-compose

            git clone https://github.com/nvm-sh/nvm.git /opt/nvm
            mkdir /usr/local/nvm
            mkdir /usr/local/node
            cp /tmp/node.sh /etc/profile.d/node.sh
            source /etc/profile.d/node.sh
            nvm install lts/gallium
            nvm alias default lts/gallium
            npm -g i yarn

            ln -s /usr/local/node/bin/yarn /usr/local/bin
            ln -s /usr/local/nvm/versions/node/v16.20.1/bin/node /usr/local/bin/

            systemctl enable apache2
            systemctl enable docker

            systemctl start apache2
            systemctl start docker

            mkdir -p /var/www/ARCVService/{archives,releases,storage} /var/www/ARCVMarket
            mkdir -p /var/www/ARCVService/storage/{app,framework/cache,framework/views,framework/sessions,logs}

            mv /tmp/htaccess /var/www/ARCVMarket/htaccess
            mv /tmp/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
            docker-compose -f /opt/docker-compose.yml up -d

            git clone https://github.com/neontribe/ARCVService.git /var/www/ARCVService/releases/initial
            ln -sf /var/www/ARCVService/releases/initial /var/www/ARCVService/current_release
            ln -sf /var/www/ARCVService/releases/initial/public /var/www/ARCVService/public_html

            # Create neontribe user
            useradd neontribe -G 10,27,33 -m -s /bin/bash -p'$y$j9T$meYS16UGzh89g1xG3SBbO.$IYVlPOma/yHhprOOKlz1dLJpF42tzu1Ze0Yn5nxMQM0' || true

            # Add default public key
            mkdir -p /home/neontribe/.ssh
            cat /tmp/id_rsa.pub >> /home/neontribe/.ssh/authorized_keys || true

            # Clean up neontribe user permisssions
            chown -R neontribe:neontribe /home/neontribe/ /var/www/ARCVService
            chmod 700 /home/neontribe/.ssh
            chmod 600 /home/neontribe/.ssh/authorized_keys
            chown -R www-data:www-data /var/www/ARCVService/storage/ /var/www/ARCVService/releases/*/bootstrap

            echo -e "[mysqldump]\ncolumn-statistics=0\n" >> /etc/mysql/my.cnf

            echo "+------------------------------------------+"
            echo "| neontribe user created, password set to: |"
            echo "|     Zooloander123!                       |"
            echo "| MySQL root password:                     |"
            echo "|     changemeplease                       |"
            echo "+------------------------------------------+"
            echo "eth1 ip address: $(ip -4 addr)"
        SHELL


        arctest.vm.provision "shell", inline: <<-SHELL
            mv /tmp/arc.conf /etc/apache2/sites-available/arc.conf
            a2ensite arc
            a2enmod rewrite vhost_alias
            a2dissite 000-default.conf
            systemctl reload apache2
        SHELL

        #Dir.glob("~/.ssh/*.pub") do |pubkey|
        #    arctest.vm.provision "file", source: pubkey, destination: pubkey
        #    arctest.vm.provision "shell", inline: <<-SHELL
        #        cat  #{pubkey} >> /home/neontribe/.ssh/authorized_keys
        #    SHELL
        #end
    end

end

