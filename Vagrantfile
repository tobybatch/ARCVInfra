# -*- mode: ruby -*-
# vi: set ft=ruby :

# Testing vagrant machine, se we can test deploys locally

Vagrant.configure("2") do |config|
    config.vm.define "arctest" do |arctest|
        arctest.vm.box = "ubuntu/jammy64"
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
            useradd neontribe -G 4,27,30,46 -p'$6$GjuExQMt1P$j8FLVoE07wNxYe10xTYO4M.uNzZgu008PujkDm6pstQEdg6SniZngi.LVPzsU8evYTqCGxikAiWWsxSpa/JaM1'
            mkdir -p /home/neontribe/.ssh
            echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/dxFUsOQ730CYMH8D4zLlUGrtC5CkkTK6tnKt9FvosmB/zRPh6A5CkveVWzHBWUq5o4LnREh/V5ov1sA2rkdJ8y6NA+obI1jL7UY/eiH7wPlvBKkNAx65WXCcsBYF3TAMkUROUMy8PB6+17f/zLjLvWQTkrzet+ptfdsKdIJqKPxWQy1JcSvukcG/VU9RWTwGY7kvWRF8dxJHWE3LUKbJiNq6xGOLsPI25fkjwW+sBi5Nmcononz3XToHtD5bl76SnlHQ43auaxp4IMPQkcLz5sZTstKxkPmBY+kUL6U9GnYc+QcxCV35H8f8wH8DfxivledBUo6gHzjEzh34s67hwlfzxkuH/DYO247XlPLxm0oPJuANzDlYdY8ly52CCPDX9sFa1mLGtP3mpp+yhTRA5M/IrPolqBDn7C3BV79GyVjB4Z6yZiRJlsaqGwxHl46wNKSA0UOjZm2DaPuFXFVHGYxwuc50a4zLGTCmQC4gmb+kKHcWtHlZ02fUUN3uxXy+1Ok+HEU9XqI3PjfrftKGkc1FGDLjD2h4I8ulPIbPslVxt8iieazAEwacGlGFHoLUSbu5l7gYjuTmCHS+kP9/vQT8n2RCU7l7PH3rQYjvWZ1RQzWrPeNeJTjmSxE1LZ/rYUV/MEBdFcBqIH4g2e+tb++x8vfzw77g6Crky2n/SQ== tobias@tobias" > /home/neontribe/.ssh/authorized_keys
            chown -R neontribe:neontribe /home/neontribe/
            chmod 700 /home/neontribe/.ssh
            chmod 600 /home/neontribe/.ssh/authorized_keys
            apt install -y python-is-python3
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
