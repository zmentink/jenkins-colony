#!/usr/bin/env bash
DOCKERFILE_REPO="https://github.com/QualiSystemsLab/colony-jenkins-dockerized.git"
DOCKER_COMPOSE_VER="1.26.2"
WORKDIR="/tmp/jenkins"
COLONY_PLUGIN_URL="https://docs.google.com/uc?export=download&id=1fuLqNHF8aheTw1cCM2EZlpV2-F_zcXvK"  # TODO: replace with correct link to plugin binary

set -o errexit
set -o nounset

echo "==> Starting deployment"
# Docker
apt update
apt --yes --no-install-recommends install apt-transport-https ca-certificates git
wget --quiet --output-document=- https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable"
apt update
apt --yes --no-install-recommends install docker-ce docker-ce-cli containerd.io
# usermod --append --groups docker "$USER"
systemctl enable docker
sleep 5
echo "==> docker installed successfully"

# Docker Compose
wget --output-document=/usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VER}/run.sh
chmod +x /usr/local/bin/docker-compose
wget --output-document=/etc/bash_completion.d/docker-compose "https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose"
echo "==> compose installed successfully"

# Jenkins
echo "==> Cloning jenkins installation repo"
git clone ${DOCKERFILE_REPO} ${WORKDIR}

echo "==> Preparing a job"
sed -i "s/%SPACE%/${SPACE_NAME}/g" ${WORKDIR}/master/config.xml

echo "==> Preparing a CasC config"
sed -i "s|%URL%|${CS_COLONY_URL}|g" ${WORKDIR}/master/jenkins.yaml
sed -i "s|%TOKEN%|${CS_COLONY_TOKEN}|g" ${WORKDIR}/master/jenkins.yaml

echo "==> Downloading a plugin file"
wget --no-check-certificate ${COLONY_PLUGIN_URL} -O ${WORKDIR}/master/colony.hpi

echo "==> Starting jenkins"
cd ${WORKDIR}
docker-compose -f jenkins-docker-compose.yml up -d --build --force-recreate

rm -rf ${WORKDIR}
