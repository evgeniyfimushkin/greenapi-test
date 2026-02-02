#!/bin/bash

sudo useradd -m -s /bin/bash admin
sudo passwd -l admin
sudo mkdir /home/admin/.ssh
sudo cat >/home/admin/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2SGEG/M50ikHtwUV22PExGOOuLcG127rOYWPNxhZIAzeQoKPnckgrGhC861tD6jQzFgoR/FEWP1CDrURyCtAtlclpBNkejnZoD9MttvQAJYSCRyUgcEehEqm59sebEon0ZHij4F20jWjaeIEtVZ7oUrEodaH3mrR83kV10dYc1MM/7QPQaR2fWZa4Wf4aaX+AUCs0Lj6x28i45XOsQ4F2n+k4xs1IiBVPTFFHA6QpA02p87tyvu2Yo4f6YcjNtWuvhofuE446lBwsJzyi+YhR+zFZ3ZTGrU5H8LroTXtYmqkgokwOXz6HI/1eXl+xNdZyJNJrqWuGWveUnlFdWUj1
EOF
sudo chmod 700 /home/admin/.ssh
sudo chmod 600 /home/admin/.ssh/authorized_keys
sudo chown -R admin:admin /home/admin/.ssh
echo "admin ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/admin

# Install docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo groupadd docker
sudo usermod -aG docker admin
