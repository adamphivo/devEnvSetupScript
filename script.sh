#!/bin/bash
set +e

# Update dependencies
sudo apt update 
sudo apt upgrade

# Snapd
sudo apt install snapd

# Mattermost
sudo snap install mattermost-desktop

# VSCode
sudo snap install --classic code

# Terminator
sudo apt install -y terminator
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x" 

# Thunderbird
sudo snap install thunderbird

# Postman
sudo snap install postman

#DBeaver
sudo snap install dbeaver-ce

# Insomnia
sudo snap install insomnia

# Curl
sudo apt install -y curl

# Chromium
sudo snap install chromium

# Git
sudo apt install -y git
git config --global user.email "adamphivo@gmail.com"
git config --global user.name "Adam Phi Vo"

# SSH
ssh-keygen -t ed25519 -C "adamphivo@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Zsh
sudo apt install -y zsh 

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts
nvm use --lts

# Docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg 
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
while ...
do
    newgrp docker || true
done
docker run hello-world
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Docker compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.19.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
docker compose version

# Microsoft Azure Data Studio
wget "https://go.microsoft.com/fwlink/?linkid=2198763" -O azuredatastudio.deb
sudo apt install -y libunwind8
sudo dpkg -i azuredatastudio.deb
rm azuredatastudio.deb